
DECLARE @split VARCHAR(255);

SET @split = '1515';
--SET @split = '1516';
--SET @split = '4820';

-------------------------------------------
-- 1st STEP/Test -- Get the Desired Values
-------------------------------------------
--SELECT  id ,
--        rec_ident ,
--        10 AS archive_time ,
--        2 AS action_id
--FROM    dbo.archive_queue AS REV
--INNER JOIN (
--             SELECT r.ident ,
--                    r.sgroup
--             FROM   dbo.recordings AS r
--             WHERE  r.user5 = @split
--           ) AS HGE
--ON      REV.rec_ident = HGE.ident;

--------------------------------------------------------
-- 2nd STEP/Test -- Check the Joins for the Target Table
--------------------------------------------------------
SELECT  aq.id ,
        REV.id ,
        aq.rec_ident ,
        REV.rec_ident ,
        aq.archive_time ,
        REV.archive_time AS Rev_Time ,
        aq.action_id ,
        REV.action_id AS Rev_ActionId ,
        aq.purge_rec ,
        aq.owner
FROM    dbo.archive_queue AS aq
INNER JOIN (
             SELECT id ,
                    rec_ident ,
                    10 AS archive_time , -- SOME EPOCH TIME IN THE PAST
                    2 AS action_id
             FROM   dbo.archive_queue AS REV
             INNER JOIN (
                          SELECT    r.ident ,
                                    r.sgroup
                          FROM      dbo.recordings AS r
                          WHERE     r.user5 = @split
                        ) AS HGE
             ON     REV.rec_ident = HGE.ident
           ) AS REV
ON      REV.id = aq.id;

---------------------------------------------------------
-- 3rd STEP/Exec -- Update the Target Table frm Join Test
---------------------------------------------------------
--UPDATE  dbo.archive_queue
--SET     archive_time = SRC.Rev_Time ,
--        action_id = SRC.Rev_ActionId
--FROM    dbo.archive_queue AS aq
--INNER JOIN (
--             SELECT aq.id ,
--                    aq.rec_ident ,
--                    REV.archive_time AS Rev_Time ,
--                    REV.action_id AS Rev_ActionId ,
--                    aq.purge_rec
--             FROM   dbo.archive_queue AS aq
--             INNER JOIN (
--                          SELECT    id ,
--                                    rec_ident ,
--                                    10 AS archive_time ,
--                                    2 AS action_id
--                          FROM      dbo.archive_queue AS REV
--                          INNER JOIN (
--                                       SELECT   r.ident ,
--                                                r.sgroup
--                                       FROM     dbo.recordings AS r
--                                       WHERE    r.user5 = @split
--                                     ) AS HGE
--                          ON        REV.rec_ident = HGE.ident
--                        ) AS REV
--             ON     REV.id = aq.id
--           ) AS SRC
--ON      SRC.id = aq.id;




