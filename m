Return-Path: <linux-mmc+bounces-280-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0037FD26F
	for <lists+linux-mmc@lfdr.de>; Wed, 29 Nov 2023 10:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DD151C20B88
	for <lists+linux-mmc@lfdr.de>; Wed, 29 Nov 2023 09:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF85614004;
	Wed, 29 Nov 2023 09:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KMijp0VY"
X-Original-To: linux-mmc@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C58B120
	for <linux-mmc@vger.kernel.org>; Wed, 29 Nov 2023 01:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701249940; x=1732785940;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tWhZuo1wDn2egn+HtaTHZ98H17rWGA2WemzKrI2WQlk=;
  b=KMijp0VYN8AGWxkIoaxlxMZ63neHT47Jc/QgpFOq3uyZtO5OBA+DaSqf
   mM/l/GJOW7xFBbwdn+tSaXTVWqaS3P5mASXDu/tsJgUYtvDdtOPvbKbId
   y4GOw1MYhchVwDi7uL7IInNGS6I8ANwGFiIIAhW7HLm/J9CmDIyaQubiv
   qKxSiNC6w/RN44NI68t5qb127OIyyuavNXV8+MMbxGvbMPmOXmLnBFP35
   uKmFevnyU9iLeXuLsEx3Q+TwN1NVVy+VaTNGzynrtGIdZEbbYluUmMzmc
   CIdDvrPK+C3RZQhd5X6+Z397WeFo6oX1UeXQjER+BQsxabShNNvqOakbd
   w==;
X-CSE-ConnectionGUID: ROvpXYZnQNaN/mOuCtd1bg==
X-CSE-MsgGUID: 2/P94ACrRAuG9GSydjTs/g==
X-IronPort-AV: E=Sophos;i="6.04,235,1695657600"; 
   d="scan'208";a="3700687"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Nov 2023 17:25:40 +0800
IronPort-SDR: jT3ZYHmFpniO6fFLsvPfQxLy63x5Q4Ouuiznf7IIromw5ofkbJNyAZtehOcRToL79me5XjcDev
 QNga8nRsKk+A==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Nov 2023 00:31:08 -0800
IronPort-SDR: v/c7mBj3XIq0FdHu2qWR4KY0rKpPpXP9Bwvj6PBHM3dQuhCrfn3BWwKX5oyWRovnIV4EXLghDb
 2vz+CRnZFCnw==
WDCIronportException: Internal
Received: from bxygm33.ad.shared ([10.45.31.229])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Nov 2023 01:25:38 -0800
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Daniil Lunev <dlunev@google.com>,
	Asutosh Das <quic_asutoshd@quicinc.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v4] mmc: core: Use mrq.sbc in close-ended ffu
Date: Wed, 29 Nov 2023 11:25:35 +0200
Message-ID: <20231129092535.3278-1-avri.altman@wdc.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Field Firmware Update (ffu) may use close-ended or open ended sequence.
Each such sequence is comprised of a write commands enclosed between 2
switch commands - to and from ffu mode. So for the close-ended case, it
will be: cmd6->cmd23-cmd25-cmd6.

Some host controllers however, get confused when multi-block rw is sent
without sbc, and may generate auto-cmd12 which breaks the ffu sequence.
I encountered  this issue while testing fwupd (github.com/fwupd/fwupd)
on HP Chromebook x2, a qualcomm based QC-7c, code name - strongbad.

Instead of a quirk, or hooking the request function of the msm ops,
it would be better to fix the ioctl handling and make it use mrq.sbc
instead of issuing SET_BLOCK_COUNT separately.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---

Changelog:
v3--v4:
	check sbc.error as well
v2--v3:
	Adopt Adrian's proposal
v1--v2:
	remove redundant reference of reliable write
---
 drivers/mmc/core/block.c | 46 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index f9a5cffa64b1..892e74e611a0 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -400,6 +400,10 @@ struct mmc_blk_ioc_data {
 	struct mmc_ioc_cmd ic;
 	unsigned char *buf;
 	u64 buf_bytes;
+	unsigned int flags;
+#define MMC_BLK_IOC_DROP	BIT(0)	/* drop this mrq */
+#define MMC_BLK_IOC_SBC	BIT(1)	/* use mrq.sbc */
+
 	struct mmc_rpmb_data *rpmb;
 };
 
@@ -465,7 +469,7 @@ static int mmc_blk_ioctl_copy_to_user(struct mmc_ioc_cmd __user *ic_ptr,
 }
 
 static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
-			       struct mmc_blk_ioc_data *idata)
+			       struct mmc_blk_ioc_data **idatas, int i)
 {
 	struct mmc_command cmd = {}, sbc = {};
 	struct mmc_data data = {};
@@ -475,10 +479,18 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 	unsigned int busy_timeout_ms;
 	int err;
 	unsigned int target_part;
+	struct mmc_blk_ioc_data *idata = idatas[i];
+	struct mmc_blk_ioc_data *prev_idata = NULL;
 
 	if (!card || !md || !idata)
 		return -EINVAL;
 
+	if (idata->flags & MMC_BLK_IOC_DROP)
+		return 0;
+
+	if (idata->flags & MMC_BLK_IOC_SBC)
+		prev_idata = idatas[i - 1];
+
 	/*
 	 * The RPMB accesses comes in from the character device, so we
 	 * need to target these explicitly. Else we just target the
@@ -532,7 +544,7 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 			return err;
 	}
 
-	if (idata->rpmb) {
+	if (idata->rpmb || prev_idata) {
 		sbc.opcode = MMC_SET_BLOCK_COUNT;
 		/*
 		 * We don't do any blockcount validation because the max size
@@ -540,6 +552,8 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 		 * 'Reliable Write' bit here.
 		 */
 		sbc.arg = data.blocks | (idata->ic.write_flag & BIT(31));
+		if (prev_idata)
+			sbc.arg = prev_idata->ic.arg;
 		sbc.flags = MMC_RSP_R1 | MMC_CMD_AC;
 		mrq.sbc = &sbc;
 	}
@@ -557,6 +571,15 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 	mmc_wait_for_req(card->host, &mrq);
 	memcpy(&idata->ic.response, cmd.resp, sizeof(cmd.resp));
 
+	if (prev_idata) {
+		memcpy(&prev_idata->ic.response, sbc.resp, sizeof(sbc.resp));
+		if (sbc.error) {
+			dev_err(mmc_dev(card->host), "%s: sbc error %d\n",
+							__func__, sbc.error);
+			return sbc.error;
+		}
+	}
+
 	if (cmd.error) {
 		dev_err(mmc_dev(card->host), "%s: cmd error %d\n",
 						__func__, cmd.error);
@@ -1032,6 +1055,20 @@ static inline void mmc_blk_reset_success(struct mmc_blk_data *md, int type)
 	md->reset_done &= ~type;
 }
 
+static void mmc_blk_check_sbc(struct mmc_queue_req *mq_rq)
+{
+	struct mmc_blk_ioc_data **idata = mq_rq->drv_op_data;
+	int i;
+
+	for (i = 1; i < mq_rq->ioc_count; i++) {
+		if (idata[i - 1]->ic.opcode == MMC_SET_BLOCK_COUNT &&
+		    mmc_op_multi(idata[i]->ic.opcode)) {
+			idata[i - 1]->flags |= MMC_BLK_IOC_DROP;
+			idata[i]->flags |= MMC_BLK_IOC_SBC;
+		}
+	}
+}
+
 /*
  * The non-block commands come back from the block layer after it queued it and
  * processed it with all other requests and then they get issued in this
@@ -1059,11 +1096,14 @@ static void mmc_blk_issue_drv_op(struct mmc_queue *mq, struct request *req)
 			if (ret)
 				break;
 		}
+
+		mmc_blk_check_sbc(mq_rq);
+
 		fallthrough;
 	case MMC_DRV_OP_IOCTL_RPMB:
 		idata = mq_rq->drv_op_data;
 		for (i = 0, ret = 0; i < mq_rq->ioc_count; i++) {
-			ret = __mmc_blk_ioctl_cmd(card, md, idata[i]);
+			ret = __mmc_blk_ioctl_cmd(card, md, idata, i);
 			if (ret)
 				break;
 		}
-- 
2.42.0


