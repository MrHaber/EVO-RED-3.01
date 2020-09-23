private["_i","_plr","_cmd","_recvArray","_command","_param1","_param2","_var1"];

    for "_i" from 1 to 40 step 1 do
    {
        _cmd = "";
        if (!isNil format["PTC_ES%1", _i]) then
        {
            call compile format["_cmd = PTC_ES%1",_i];
            _recvArray = toArray _cmd;
            if ((count _recvArray) > 0) then
            {
                _plr = [] call compile format ["ES%1",_i];
                if (isPlayer _plr) then
                {
                    _command =_recvArray select 0;
                    switch (_command) do
                    {
                        case FFA_CMD_VEHICLEREQUEST:
                        {
                            _price = _recvArray select 2;
                            if ((alive _plr) && ((score _plr) >= _price)) then
                            {
                                _recvArray = _recvArray + [_plr getVariable "FFA_SELFNAME"];
                                _recvArray call FFA_FUNC_VEHICLEREQUEST;
                                _plr addScore -_price;
                                [_plr] spawn FFA_FUNC_REMEMSCORE;
                            };
                        };
                        case FFA_CMD_UNITREQUEST:
                        {
                            _price = _recvArray select 3;
                            if ((alive _plr) && ((score _plr) >= _price)) then
                            {
                                _recvArray = _recvArray+[_i];
                                _recvArray call FFA_FUNC_UNITREQUEST;
                                _plr addScore -_price;
                                [_plr] spawn FFA_FUNC_REMEMSCORE;
                            };
                        };
                        case FFA_CMD_INCOMEREQUEST:
                        {
                            _param1 = _recvArray select 1;
                            _param2 = _recvArray select 2;
                            if (!isNil "_param1") then
                            {
                                _var1 = [] call compile format ["ES%1",_param1];
                                _var1 addScore _param2;
                                [_var1] spawn FFA_FUNC_REMEMSCORE;
                            };
                        };
                        case FFA_CMD_OUTCOMEREQUEST:
                        {
                            _param1 = _recvArray select 1;
                            if (!isNil "_plr") then
                            {
                                _plr addScore -_param1;
                                [_plr] spawn FFA_FUNC_REMEMSCORE;
                            };
                        };
                        case FFA_CMD_TRANSFERREQUEST:
                        {
                            _param2 = _recvArray select 2;
                            if ((score _plr) >= _param2) then
                            {
                                _param1 = _recvArray select 1;
                                if (!isNil "_param1") then
                                {
                                    FFA_TRANSFER_POINTS = _param2;
                                    publicVariable "FFA_TRANSFER_POINTS";
                                    _plr addScore -_param2;
                                    [_plr] spawn FFA_FUNC_REMEMSCORE;
                                    FFA_TRANSFER_UNIT = _plr;
                                    publicVariable "FFA_TRANSFER_UNIT";
                                    _var1 = [] call compile format ["ES%1",_param1];
                                    _var1 addScore _param2;
                                    [_var1] spawn FFA_FUNC_REMEMSCORE;
                                    FFA_TRANSFER_TARGET = _var1;
                                    publicVariable "FFA_TRANSFER_TARGET";
                                };
                            };
                        };
                    };
                };
            };
        };
       call compile format['PTC_ES%1 = nil',_i];
    };
