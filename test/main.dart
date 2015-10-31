library core.test;

@TestOn("dartium")


import "dart:async";
import "dart:convert";

import 'package:test/test.dart';
import 'package:core/core.dart';
import 'package:core/models/models.dart';
import 'package:data/data.dart' as data;

void main() {
    test('test user', () async {
        data.DB db = new data.MemoryDB();
        db.RegisterKind(UserKind, UserSpace, NewUser);

        User user = new User("Nick");
        expect(user.name, "Nick");
        user.id = "1";

        db.Save(user);

        var retrieved = await User.find(db, "1");

        expect(retrieved, user);
    });

    test('test user parsing', () {
        DateTime c = new DateTime.now();

        Map<String, dynamic> userJSONObject = {
            "id": "1",
            "created_at": c,
            "updated_at": new DateTime.now(),
            "deleted_at": null,
            "credential_ids": ["1", "2", "3"],
        };

        String userJSONString = JSON.encode(userJSONObject, toEncodable: data.JSONEncoder);

        User u = new User.fromStructure(JSON.decode(userJSONString));

        expect(u.id, "1");
        expect(u.created_at, c);
    });

    test('has many of user', () async {
        data.DB db = new data.MemoryDB();
        db.RegisterKind(UserKind, UserSpace,  NewUser);
        db.RegisterKind(GroupKind, GroupKind, NewGroup);

        User u = new User("nick");
        u.id = "1";

        Group g = u.newGroup("one", 1);
        g.id = "1";
        Group g2 =  u.newGroup("two", 1);
        g2.id = "2";
        Group rando = new Group("rando", 1, "other user's id");
        rando.id = "3";


        db.Save(u);
        db.Save(g);
        db.Save(g2);
        db.Save(rando);

        Group rg = await db.Find(GroupKind, "2");
        expect(rg.name, "two");

        Stream<Group> stream = u.groups(db);
        List<Group> groups = await stream.toList();

        expect(groups.length, 2);
    });

    test("REST DB", () {
        Authenticate("http://localhost:8000", "public", "private").then( (token) {
            ElosHost h = new ElosHost("http://localhost:8000", token);
            data.RestDB rdb = new data.RestDB(h);
            expect(true, true);
        });
    });

    test('Session', () async {
        Session session = await Session.Authenticate("http://localhost:8000", "public", "private");

        ElosHost h = new ElosHost("http://localhost:8000", session.token);
        data.DB db = new data.RestDB(h);
        db.RegisterKind(UserKind, UserSpace, NewUser);
        db.RegisterKind(GroupKind, GroupSpace, NewGroup);

        User u = await db.Find(UserKind, session.owner_id);

        expect(u.id, session.owner_id);

        Group g = u.newGroup("New Group", 2);
        expect(g.owner_id, u.id);

        Group gsaved = await db.Save(g);
        expect(gsaved.owner_id, u.id);
    });
}
