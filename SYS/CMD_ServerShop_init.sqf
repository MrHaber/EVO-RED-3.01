[] spawn
    {
        private["_script","_shop_handler"];

        waitUntil{FFA_SERVERSTARTED};

        _shop_handler = compile preprocessFileLineNumbers "SYS\CMD_ServerShop.sqf";

        while {!(FFA_GAMEENDED)} do
        {
            _script = [] spawn _shop_handler;
            waitUntil { scriptDone _script };
            sleep 5;
        };
    };