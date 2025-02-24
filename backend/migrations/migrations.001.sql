CREATE TABLE "user" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "username" VARCHAR(255) NOT NULL,
    "email" VARCHAR(255) NOT NULL,
    "password" TEXT NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "profile_image" TEXT NULL,
    "bio" TEXT NULL,
    "profile_status" VARCHAR(255) CHECK
        ("profile_status" IN('active', 'inactive', 'pending')) NOT NULL DEFAULT 'active',
    "is_active" BOOLEAN NOT NULL DEFAULT True,
    "is_admin" BOOLEAN NOT NULL DEFAULT False,
    "is_verified" BOOLEAN NOT NULL DEFAULT False,
    "birthDate" DATE NOT NULL,
    "city" VARCHAR(255) NOT NULL,
    CONSTRAINT "user_pkey" PRIMARY KEY ("id"),
    CONSTRAINT "user_username_unique" UNIQUE ("username"),
    CONSTRAINT "user_email_unique" UNIQUE ("email")
);

CREATE TABLE "friends" (
    "sent_ID" INT NOT NULL,
    "recived_ID" INT NOT NULL,
    "dateSend" DATE NOT NULL,
    "status" VARCHAR(255) CHECK
        ("status" IN('pending', 'accepted', 'declined')) NOT NULL,
    "Date_accepted" DATE NULL,
    "date_declined" DATE NULL,
    CONSTRAINT "friends_pkey" PRIMARY KEY ("sent_ID", "recived_ID"),
    CONSTRAINT "friends_sent_id_foreign" FOREIGN KEY ("sent_ID") REFERENCES "user"("id"),
    CONSTRAINT "friends_recived_id_foreign" FOREIGN KEY ("recived_ID") REFERENCES "user"("id"),
    CHECK ("sent_ID" < "recived_ID") -- Prevent duplicate friendships
);

CREATE TABLE "messages" (
    "id" SERIAL NOT NULL,
    "sender_id" INT NOT NULL,
    "contentType" VARCHAR(255) CHECK
        ("contentType" IN('text', 'image', 'video')) NOT NULL,
    "content" JSON NOT NULL,
    "dateSent" DATE NOT NULL,
    "chat_id" INT NOT NULL,
    CONSTRAINT "messages_pkey" PRIMARY KEY ("id"),
    CONSTRAINT "messages_sender_id_foreign" FOREIGN KEY ("sender_id") REFERENCES "user"("id"),
    CONSTRAINT "messages_chat_id_foreign" FOREIGN KEY ("chat_id") REFERENCES "chat"("id")
);

CREATE TABLE "chat" (
    "id" SERIAL NOT NULL,
    "StartAt" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    "type" VARCHAR(255) CHECK
        ("type" IN('private', 'group')) NOT NULL,
    CONSTRAINT "chat_pkey" PRIMARY KEY ("id")
);

CREATE TABLE "Participation" (
    "user_ID" INT NOT NULL,
    "chat_ID" INT NOT NULL,
    "Date_joined" DATE NOT NULL,
    CONSTRAINT "participation_pkey" PRIMARY KEY ("user_ID", "chat_ID"),
    CONSTRAINT "participation_user_id_foreign" FOREIGN KEY ("user_ID") REFERENCES "user"("id"),
    CONSTRAINT "participation_chat_id_foreign" FOREIGN KEY ("chat_ID") REFERENCES "chat"("id")
);

CREATE TABLE "group" (
    "id" SERIAL NOT NULL,
    "profile_pic" TEXT NOT NULL,
    "group_name" VARCHAR(255) NOT NULL,
    "group_description" TEXT NOT NULL,
    CONSTRAINT "group_pkey" PRIMARY KEY ("id")
);

CREATE TABLE "group_admin" (
    "user_id" INT NOT NULL,
    "group_id" INT NOT NULL,
    "access_level" VARCHAR(255) CHECK
        ("access_level" IN('admin', 'moderator')) NOT NULL,
    CONSTRAINT "group_admin_pkey" PRIMARY KEY ("user_id", "group_id"),
    CONSTRAINT "group_admin_user_id_foreign" FOREIGN KEY ("user_id") REFERENCES "USER"("id"),
    CONSTRAINT "group_admin_group_id_foreign" FOREIGN KEY ("group_id") REFERENCES "group"("id")
);