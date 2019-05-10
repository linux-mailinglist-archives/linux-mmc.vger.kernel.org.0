Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50AEF19C87
	for <lists+linux-mmc@lfdr.de>; Fri, 10 May 2019 13:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbfEJLZJ (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 10 May 2019 07:25:09 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:41972 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbfEJLZJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 10 May 2019 07:25:09 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4ABOFvb175227;
        Fri, 10 May 2019 11:24:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=Ejs4I4fqYg5vVJqbbCRP4lri4W3RXcnsuGcZBot6xbU=;
 b=WQxVU5F5LwBN/zg8GZJ6cJDqbze83J4IiKZ+qdMuVrC5KBvvWGUx9RdPEjLP8uJ0mkOT
 h1QASbcAo1YTSWA0FWLLjOKvpcOOeVcdI51uYX5tUTKajH3vwXEs+se12++W3sdvCWpa
 qPlNn63FXh7HUxjZV1Jk0e9pQ9A9Yn/V03KiJex5xnLZaawkO6vS5ejcgQTlJm6yby1E
 SYZ2rKG0h6mV4WNaPHr3CQnzq4io2HEDzppVm+kysdIztVY0UNPFg/sutMfzgIEx0HTv
 vrJy6i6Nj32J61gmllGJ99xF3dTGjl/z09952DUs1UPPXS9EAQqZh6r1K5z3bPoU4uYv iw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 2s94b6gecu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 May 2019 11:24:53 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4ABN8PZ037501;
        Fri, 10 May 2019 11:24:53 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2scpy6726d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 May 2019 11:24:53 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4ABOndT028198;
        Fri, 10 May 2019 11:24:49 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 10 May 2019 11:24:49 +0000
Date:   Fri, 10 May 2019 14:24:41 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Alex Dubov <oakad@yahoo.com>, Ulf Hansson <ulf.hansson@linaro.org>,
        Hannes Reinecke <hare@suse.de>,
        Martin Wilck <martin.wilck@suse.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-mmc@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] mspro_block: Fix an error code in mspro_block_issue_req()
Message-ID: <20190510112440.GA22858@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9252 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905100081
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9252 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905100081
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

We accidentally changed the error code from -EAGAIN to 1 when we did the
blk-mq conversion.

Maybe a contributing factor to this mistake is that it wasn't obvious
that the "while (chunk) {" condition is always true.  I have cleaned
that up as well.

Fixes: d0be12274dad ("mspro_block: convert to blk-mq")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/memstick/core/mspro_block.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/memstick/core/mspro_block.c b/drivers/memstick/core/mspro_block.c
index aba50ec98b4d..9fc22c755dbf 100644
--- a/drivers/memstick/core/mspro_block.c
+++ b/drivers/memstick/core/mspro_block.c
@@ -694,13 +694,13 @@ static void h_mspro_block_setup_cmd(struct memstick_dev *card, u64 offset,
 
 /*** Data transfer ***/
 
-static int mspro_block_issue_req(struct memstick_dev *card, bool chunk)
+static int mspro_block_issue_req(struct memstick_dev *card)
 {
 	struct mspro_block_data *msb = memstick_get_drvdata(card);
 	u64 t_off;
 	unsigned int count;
 
-	while (chunk) {
+	while (true) {
 		msb->current_page = 0;
 		msb->current_seg = 0;
 		msb->seg_count = blk_rq_map_sg(msb->block_req->q,
@@ -709,6 +709,7 @@ static int mspro_block_issue_req(struct memstick_dev *card, bool chunk)
 
 		if (!msb->seg_count) {
 			unsigned int bytes = blk_rq_cur_bytes(msb->block_req);
+			bool chunk;
 
 			chunk = blk_update_request(msb->block_req,
 							BLK_STS_RESOURCE,
@@ -718,7 +719,7 @@ static int mspro_block_issue_req(struct memstick_dev *card, bool chunk)
 			__blk_mq_end_request(msb->block_req,
 						BLK_STS_RESOURCE);
 			msb->block_req = NULL;
-			break;
+			return -EAGAIN;
 		}
 
 		t_off = blk_rq_pos(msb->block_req);
@@ -735,8 +736,6 @@ static int mspro_block_issue_req(struct memstick_dev *card, bool chunk)
 		memstick_new_req(card->host);
 		return 0;
 	}
-
-	return 1;
 }
 
 static int mspro_block_complete_req(struct memstick_dev *card, int error)
@@ -779,7 +778,7 @@ static int mspro_block_complete_req(struct memstick_dev *card, int error)
 		chunk = blk_update_request(msb->block_req,
 				errno_to_blk_status(error), t_len);
 		if (chunk) {
-			error = mspro_block_issue_req(card, chunk);
+			error = mspro_block_issue_req(card);
 			if (!error)
 				goto out;
 		} else {
@@ -849,7 +848,7 @@ static blk_status_t mspro_queue_rq(struct blk_mq_hw_ctx *hctx,
 	msb->block_req = bd->rq;
 	blk_mq_start_request(bd->rq);
 
-	if (mspro_block_issue_req(card, true))
+	if (mspro_block_issue_req(card))
 		msb->block_req = NULL;
 
 	spin_unlock_irq(&msb->q_lock);
-- 
2.18.0

