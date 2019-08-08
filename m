Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8053185E2C
	for <lists+linux-mmc@lfdr.de>; Thu,  8 Aug 2019 11:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732098AbfHHJYF (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 8 Aug 2019 05:24:05 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:31379 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730678AbfHHJYF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Aug 2019 05:24:05 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190808092402epoutp04786c0de94dae114fbaf3ad8037e9c154~46EJq2h920542605426epoutp04U
        for <linux-mmc@vger.kernel.org>; Thu,  8 Aug 2019 09:24:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190808092402epoutp04786c0de94dae114fbaf3ad8037e9c154~46EJq2h920542605426epoutp04U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1565256242;
        bh=WI23ltb4jb+ygu8YEM6L7YgwDfxCQ5Em3kwg2Un7oUI=;
        h=From:To:Cc:Subject:Date:References:From;
        b=akybAPW8mG5gxoHJSk2wNfLzoXTU3FHo2/2r9M2jKSkf0Muh6Ikc51AkYuXMet68v
         ZzEGb2ImEJAYTxsGKtLrBP8DkaXGpjVjIogLVX53FdCYO8oe3hRV4Vug9+xRdVrtm1
         oEvM/+kZLvhEVN/iO6ts8XDHp/fYba0KKWCxYoEk=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190808092401epcas1p1e0cb678fbb9b1e8409bd6f1dcbf7b9b1~46EJJnaEl2678626786epcas1p12;
        Thu,  8 Aug 2019 09:24:01 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.163]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4642xV6sMvzMqYll; Thu,  8 Aug
        2019 09:23:58 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        4C.3D.04160.E2AEB4D5; Thu,  8 Aug 2019 18:23:58 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190808092358epcas1p4076172a9e140332c0ddaa13fac18987b~46EGC0LX71669916699epcas1p4o;
        Thu,  8 Aug 2019 09:23:58 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190808092358epsmtrp2cee92d1d187110e9aec3311355e7d605~46EGCHoo-0745907459epsmtrp2V;
        Thu,  8 Aug 2019 09:23:58 +0000 (GMT)
X-AuditID: b6c32a38-b4bff70000001040-45-5d4bea2eb9f3
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F9.D0.03706.E2AEB4D5; Thu,  8 Aug 2019 18:23:58 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.100.192]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190808092358epsmtip18f330ea675e5a0b1066680ce8492b9d0~46EF55FTh2794327943epsmtip1c;
        Thu,  8 Aug 2019 09:23:58 +0000 (GMT)
From:   Jungseung Lee <js07.lee@samsung.com>
To:     Avri Altman <Avri.Altman@wdc.com>, Chris Ball <chris@printf.net>,
        linux-mmc@vger.kernel.org, js07.lee@gmail.com
Cc:     Jungseung Lee <js07.lee@samsung.com>
Subject: [PATCH v2] mmc-utils: feature spec 5.0+, add secure removal type
 fileds to Extended CSD
Date:   Thu,  8 Aug 2019 18:23:41 +0900
Message-Id: <20190808092341.3610-1-js07.lee@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCKsWRmVeSWpSXmKPExsWy7bCmvq7eK+9Yg6Zec4uXP6+yWUy4vJ3R
        4u+cd0wWj27+ZrU48r+f0YHVY+esu+weN14tZPLo27KK0ePzJjmP9gPdTAGsUTk2GamJKalF
        Cql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUDLlRTKEnNKgUIBicXF
        Svp2NkX5pSWpChn5xSW2SqkFKTkFhgYFesWJucWleel6yfm5VoYGBkamQJUJORkLZzWzFVwV
        q3jzuYm9gfGcYBcjB4eEgInEpQfcXYxcHEICOxgl9tw7wQThfGKUWHpuIRuE841Rov35fdYu
        Rk6wjmWLVzFCJPYySmycNw2q6jOjxJIPjewgVWwCWhI3fm8C6xARKJX4/qKFCcRmFtCQ+H3g
        JguILSyQJHF95VuwOIuAqsTd931gNq+AhcTe/1cZIbbJS6zecIAZZIGEwE9WiZ7Hy1ggEi4S
        F/9dYoKwhSVeHd/CDmFLSXx+t5cNwi6W2LlyIjtEcwujxKPlS6CKjCXevV3LDAoBZgFNifW7
        9CHCihI7f89lhDiUT+Ld1x5WSCDxSnS0CUGUKEm8edACdYKExIXHvdBQ8ZBY33wTrFVIIFbi
        z4IVTBMYZWchLFjAyLiKUSy1oDg3PbXYsMAEOZY2MYJTlJbFDsY953wOMQpwMCrx8DJc8IoV
        Yk0sK67MPcQowcGsJMJ7r8wzVog3JbGyKrUoP76oNCe1+BCjKTD0JjJLiSbnA9NnXkm8oamR
        sbGxhYmZuZmpsZI478IfFrFCAumJJanZqakFqUUwfUwcnFINjI4drF+ip05ia33cqHngdrv/
        lTi1eaUztnGIFJznVBHw+h6i4+EfXLFiwi6Dl7yzL4l634nvUnj/3W/rjeT/q3c1V4UveL0j
        b/GnU0E3tA9scsuwNnbXOffgj2PvT4kvocaegkEbUirOt8fOnnHB3Jmpab7uQm/RxOXd02Z/
        ZP1Tyvr1Xt7xciWW4oxEQy3mouJEACd/VslnAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgluLIzCtJLcpLzFFi42LZdlhJTlfvlXeswbof8hYvf15ls5hweTuj
        xd8575gsHt38zWpx5H8/owOrx85Zd9k9brxayOTRt2UVo8fnTXIe7Qe6mQJYo7hsUlJzMstS
        i/TtErgyFs5qZiu4Klbx5nMTewPjOcEuRk4OCQETiWWLVzGC2EICuxklnv2VgohLSDza+YWl
        i5EDyBaWOHy4uIuRC6jkI6PEn2fzWUBq2AS0JG783sQKYosIVErM7f/DBGIzC2hI/D5wE6xG
        WCBB4vy6jWA1LAKqEnff94HV8ApYSOz9f5URYpe8xOoNB5gnMPIsYGRYxSiZWlCcm55bbFhg
        mJdarlecmFtcmpeul5yfu4kRHC5amjsYLy+JP8QowMGoxMPLcMErVog1say4MvcQowQHs5II
        770yz1gh3pTEyqrUovz4otKc1OJDjNIcLErivE/zjkUKCaQnlqRmp6YWpBbBZJk4OKUaGA0m
        v9Rzv//Vjun1zcSq/uuuN17ou1wrUj+8/8LXt1G/Jop+Oqa3ZNbkWRad86UvH5MN793Hd9Nr
        SR378SX/dgtNWtex7ugfgfIvQX3F2x4UM8uH3biUFvRunUPhiXVK25/s7r172i/OZUWRUo0c
        w4nAyOkVS0ozluXaRogo/A0W/qF6d0Zx9EclluKMREMt5qLiRADt45bVEwIAAA==
X-CMS-MailID: 20190808092358epcas1p4076172a9e140332c0ddaa13fac18987b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190808092358epcas1p4076172a9e140332c0ddaa13fac18987b
References: <CGME20190808092358epcas1p4076172a9e140332c0ddaa13fac18987b@epcas1p4.samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Display secure removal type when printing Extended CSD
Example:
	# mmc extcsd read /dev/mmcblk0
	...
        Secure Removal Type [SECURE_REMOVAL_TYPE]: 0x39
         information is configured to be removed using a vendor defined
         Supported Secure Removal Type:
          information removed by an erase of the physical memory
          information removed using a vendor defined

Signed-off-by: Jungseung Lee <js07.lee@samsung.com>
---
 mmc.h      |  3 +++
 mmc_cmds.c | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/mmc.h b/mmc.h
index 285c1f1..648fb26 100644
--- a/mmc.h
+++ b/mmc.h
@@ -116,6 +116,7 @@
 #define EXT_CSD_MODE_CONFIG		30
 #define EXT_CSD_MODE_OPERATION_CODES	29	/* W */
 #define EXT_CSD_FFU_STATUS		26	/* R */
+#define EXT_CSD_SECURE_REMOVAL_TYPE	16	/* R/W */
 #define EXT_CSD_CMDQ_MODE_EN		15	/* R/W */
 
 /*
@@ -132,6 +133,8 @@
 /*
  * EXT_CSD field definitions
  */
+#define EXT_CSD_CONFIG_SECRM_TYPE	(0x30)
+#define EXT_CSD_SUPPORTED_SECRM_TYPE	(0x0f)
 #define EXT_CSD_FFU_INSTALL		(0x01)
 #define EXT_CSD_FFU_MODE		(0x01)
 #define EXT_CSD_NORMAL_MODE		(0x00)
diff --git a/mmc_cmds.c b/mmc_cmds.c
index 19a9da1..fb37189 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -1766,6 +1766,38 @@ int do_read_extcsd(int nargs, char **argv)
 			ext_csd[EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_B]);
 		printf("eMMC Pre EOL information [EXT_CSD_PRE_EOL_INFO]: 0x%02x\n",
 			ext_csd[EXT_CSD_PRE_EOL_INFO]);
+		reg = ext_csd[EXT_CSD_SECURE_REMOVAL_TYPE];
+		printf("Secure Removal Type [SECURE_REMOVAL_TYPE]: 0x%02x\n", reg);
+		printf(" information is configured to be removed ");
+		/* Bit [5:4]: Configure Secure Removal Type */
+		switch ((reg & EXT_CSD_CONFIG_SECRM_TYPE) >> 4) {
+			case 0x0:
+				printf("by an erase of the physical memory\n");
+				break;
+			case 0x1:
+				printf("by an overwriting the addressed locations"
+				       " with a character followed by an erase\n");
+				break;
+			case 0x2:
+				printf("by an overwriting the addressed locations"
+				       " with a character, its complement, then a random character\n");
+				break;
+			case 0x3:
+				printf("using a vendor defined\n");
+				break;
+		}
+		/* Bit [3:0]: Supported Secure Removal Type */
+		printf(" Supported Secure Removal Type:\n");
+		if (reg & 0x01)
+			printf("  information removed by an erase of the physical memory\n");
+		if (reg & 0x02)
+			printf("  information removed by an overwriting the addressed locations"
+			       " with a character followed by an erase\n");
+		if (reg & 0x04)
+			printf("  information removed by an overwriting the addressed locations"
+			       " with a character, its complement, then a random character\n");
+		if (reg & 0x08)
+			printf("  information removed using a vendor defined\n");
 	}
 
 	if (ext_csd_rev >= 8) {
-- 
2.17.1

