-- Items
-- types (1=ROOT, 2=Group, 3=Folder, 4=App, 5=t, 6=Widgets)

-- apps
-- app_sources
-- image_cache(item_id) > items
-- widgets(item_id, category_id) > items, category
-- widget_sources
-- downloading_apps(item_id, category_id) > items, category
-- items(parent_id) > items
-- categories   
-- groups(item_id, category_id) > items, category

BEGIN;
PRAGMA temp_store = 2;

-- Store variables
    CREATE TEMP TABLE _Vars(name TEXT PRIMARY KEY, val INTEGER, TextValue TEXT);

-- Remove apps from Launchpad
    DELETE FROM items WHERE rowid IN (
        SELECT item_id FROM apps WHERE title IN (
            'Bluetooth File Exchange', 'Boot Camp Assistant', 'ColorSync Utility', 'TextEdit',
            'VoiceOver Utility', 'Audio MIDI Setup', 'Mission Control', 'Photo Booth',
            'Dictionary', 'Dashboard', 'Stickies', 'Contacts', 'Preview', 'Stocks', 'Chess', 'Maps', 'Mail'
        )
    );

-- Rename defaults folder to Apple
    UPDATE groups SET title = "Apple" WHERE title = 'Other';

-- Launchpad space
    INSERT INTO _Vars (name, val) VALUES ('FirstSpace', (SELECT rowid FROM items WHERE parent_id = 1 AND uuid <> 'HOLDINGPAGE'  ORDER BY ordering ASC LIMIT 1 OFFSET 0));
    INSERT INTO _Vars (name, val) VALUES ('SecondSpace', (SELECT rowid FROM items WHERE parent_id = 1 AND uuid <> 'HOLDINGPAGE'  ORDER BY ordering ASC LIMIT 1 OFFSET 1));

--  Apple folder id
    INSERT INTO _Vars (name, val) VALUES ('AppleGroup', (SELECT item_id FROM groups WHERE title = 'Apple' LIMIT 1));
    INSERT INTO _Vars (name, val) VALUES ('AppleFolder', (SELECT rowid FROM items WHERE parent_id = (SELECT val FROM _Vars WHERE name = 'AppleGroup') AND type = 3));

-- Put apps into apple folder
    UPDATE items SET parent_id=(SELECT val FROM _Vars WHERE name = 'AppleFolder') WHERE rowid IN(
        SELECT item_id FROM apps WHERE title IN ('Voice Memos', 'Calculator', 'iTunes', 'Books', 'Home', 'Siri', 'Reminders')
    );

-- From second space to first space
    UPDATE items SET parent_id=(SELECT val FROM _Vars WHERE name = 'FirstSpace') WHERE parent_id=(SELECT val FROM _Vars WHERE name = 'SecondSpace');

-- Order
    UPDATE items SET ordering = 00 WHERE rowid = (SELECT val FROM _Vars WHERE name = 'AppleGroup');
    UPDATE items SET ordering = 00 WHERE rowid = (SELECT val FROM _Vars WHERE name = 'AppleFolder');
    UPDATE items SET ordering = 01 WHERE rowid = (SELECT item_id FROM apps WHERE title = 'App Store');
    UPDATE items SET ordering = 02 WHERE rowid = (SELECT item_id FROM apps WHERE title = 'Calendar');
    UPDATE items SET ordering = 03 WHERE rowid = (SELECT item_id FROM apps WHERE title = 'Spark');
    UPDATE items SET ordering = 04 WHERE rowid = (SELECT item_id FROM apps WHERE title = 'Safari');
    UPDATE items SET ordering = 05 WHERE rowid = (SELECT item_id FROM apps WHERE title = 'Google Chrome');
    UPDATE items SET ordering = 06 WHERE rowid = (SELECT item_id FROM apps WHERE title = 'Visual Studio Code');
    UPDATE items SET ordering = 07 WHERE rowid = (SELECT item_id FROM apps WHERE title = 'Sublime Text');
    UPDATE items SET ordering = 08 WHERE rowid = (SELECT item_id FROM apps WHERE title = 'iTerm');
    UPDATE items SET ordering = 09 WHERE rowid = (SELECT item_id FROM apps WHERE title = 'Sequel Pro');
    UPDATE items SET ordering = 10 WHERE rowid = (SELECT item_id FROM apps WHERE title = 'TablePlus');
    UPDATE items SET ordering = 11 WHERE rowid = (SELECT item_id FROM apps WHERE title = 'Cyberduck');
    UPDATE items SET ordering = 12 WHERE rowid = (SELECT item_id FROM apps WHERE title = 'Dash');
    UPDATE items SET ordering = 13 WHERE rowid = (SELECT item_id FROM apps WHERE title = 'Slack');
    UPDATE items SET ordering = 14 WHERE rowid = (SELECT item_id FROM apps WHERE title = 'Skype');
    UPDATE items SET ordering = 15 WHERE rowid = (SELECT item_id FROM apps WHERE title = 'WhatsApp');
    UPDATE items SET ordering = 16 WHERE rowid = (SELECT item_id FROM apps WHERE title = 'Telegram');
    UPDATE items SET ordering = 17 WHERE rowid = (SELECT item_id FROM apps WHERE title = 'Franz');
    UPDATE items SET ordering = 18 WHERE rowid = (SELECT item_id FROM apps WHERE title = 'Spotify');
    UPDATE items SET ordering = 19 WHERE rowid = (SELECT item_id FROM apps WHERE title = 'Evernote');
    UPDATE items SET ordering = 20 WHERE rowid = (SELECT item_id FROM apps WHERE title = 'Notes');
    UPDATE items SET ordering = 21 WHERE rowid = (SELECT item_id FROM apps WHERE title = 'Kindle');
    UPDATE items SET ordering = 22 WHERE rowid = (SELECT item_id FROM apps WHERE title = 'Dashlane');
    UPDATE items SET ordering = 23 WHERE rowid = (SELECT item_id FROM apps WHERE title = 'Stremio');

    UPDATE items SET ordering = 35 WHERE rowid = (SELECT item_id FROM apps WHERE title = 'FaceTime');
    UPDATE items SET ordering = 36 WHERE rowid = (SELECT item_id FROM apps WHERE title = 'Photos');
    UPDATE items SET ordering = 37 WHERE rowid = (SELECT item_id FROM apps WHERE title = 'Pages');
    UPDATE items SET ordering = 38 WHERE rowid = (SELECT item_id FROM apps WHERE title = 'Numbers');
    UPDATE items SET ordering = 39 WHERE rowid = (SELECT item_id FROM apps WHERE title = 'Keynote');
    UPDATE items SET ordering = 40 WHERE rowid = (SELECT item_id FROM apps WHERE title = 'Grammarly');

    UPDATE items SET ordering = 42 WHERE rowid = (SELECT item_id FROM apps WHERE title = 'Lightshot Screenshot');
    UPDATE items SET ordering = 43 WHERE rowid = (SELECT item_id FROM apps WHERE title = 'GIF Brewery 3');
    UPDATE items SET ordering = 44 WHERE rowid = (SELECT item_id FROM apps WHERE title = 'Gifski');
    UPDATE items SET ordering = 45 WHERE rowid = (SELECT item_id FROM apps WHERE title = 'Macs Fan Control');
    UPDATE items SET ordering = 46 WHERE rowid = (SELECT item_id FROM apps WHERE title = 'Magnet');
    UPDATE items SET ordering = 47 WHERE rowid = (SELECT item_id FROM apps WHERE title = 'iStat Menus');
    UPDATE items SET ordering = 48 WHERE rowid = (SELECT item_id FROM apps WHERE title = 'AppCleaner');
    UPDATE items SET ordering = 49 WHERE rowid = (SELECT item_id FROM apps WHERE title = 'Backup and sync from Google');
    UPDATE items SET ordering = 50 WHERE rowid = (SELECT item_id FROM apps WHERE title = 'System Preferences');

-- .headers on
-- .mode column
-- SELECT * FROM items LEFT JOIN apps ON apps.item_id = items.rowid LEFT JOIN groups ON groups.item_id = items.rowid ORDER BY parent_id, ordering ASC;

DROP TABLE _Vars;
END;
