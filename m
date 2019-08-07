Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A01DE8486F
	for <lists+linux-mmc@lfdr.de>; Wed,  7 Aug 2019 11:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbfHGJKR (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 7 Aug 2019 05:10:17 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:60232 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbfHGJKR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Aug 2019 05:10:17 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190807091014epoutp042292f7a66d865bbf5519395393285f60~4mO0lb26d0730507305epoutp04p
        for <linux-mmc@vger.kernel.org>; Wed,  7 Aug 2019 09:10:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190807091014epoutp042292f7a66d865bbf5519395393285f60~4mO0lb26d0730507305epoutp04p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1565169014;
        bh=FFjiozFTpFgiVQvw2anEhxG/6QQ4z4ynQiPglqunJZI=;
        h=From:To:Cc:Subject:Date:References:From;
        b=R1d1Gf1k81LouV2+lPuXjXod9v33xjsu/ggDdKZY8JJN3rqGgFD0z++WpY7FdRzAj
         lN3CNywTNlAAHV98JZwSD9aUiLOLimOiYoxMckEyyF5ZRQoIeVttkeNEinIW+S467k
         wCo/3gz/o/3vrVZnOYAS3mLg27tlTwRx7acbe9is=
Received: from epsnrtp6.localdomain (unknown [182.195.42.167]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190807091014epcas1p3c90c5d17407608de1ac17a05ad5f649b~4mO0U6vnR1163811638epcas1p3w;
        Wed,  7 Aug 2019 09:10:14 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.161]) by
        epsnrtp6.localdomain (Postfix) with ESMTP id 463Qh51WfnzMqYkc; Wed,  7 Aug
        2019 09:10:13 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        A2.10.04066.5759A4D5; Wed,  7 Aug 2019 18:10:13 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190807091012epcas1p2d949c05b6dafb0a22f6babe13c5ae9c8~4mOyu9ShY3249132491epcas1p2V;
        Wed,  7 Aug 2019 09:10:12 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190807091012epsmtrp245371f8ab8399577eb82c4101610d20d~4mOyuRtY21255812558epsmtrp2z;
        Wed,  7 Aug 2019 09:10:12 +0000 (GMT)
X-AuditID: b6c32a37-e27ff70000000fe2-f5-5d4a9575f28f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5C.9F.03638.4759A4D5; Wed,  7 Aug 2019 18:10:12 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.100.192]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190807091012epsmtip13c0e3bc56f24e0b0c199bb2200bf8764~4mOymM6xx1161611616epsmtip1Y;
        Wed,  7 Aug 2019 09:10:12 +0000 (GMT)
From:   Jungseung Lee <js07.lee@samsung.com>
To:     Chris Ball <chris@printf.net>, linux-mmc@vger.kernel.org,
        js07.lee@gmail.com
Cc:     Jungseung Lee <js07.lee@samsung.com>
Subject: [PATCH] mmc-utils: feature spec 5.0+, add secure removal type
 fileds to Extended CSD
Date:   Wed,  7 Aug 2019 18:10:01 +0900
Message-Id: <20190807091001.2957-1-js07.lee@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRTm571Xr9byMq0dRg+7ILSFujk3r6JRZLFUSAqForEu7qKjvdrd
        RMs/jERCevhATFHLECTDMsl0ka8lSkQPMFIjzXxBagpKJWqPbXdS/33n+33f+X6cc0hM/JKQ
        kkaLg7NbWBMdGII/fSGLiXJWpeoUrTe3MWXDnYj5VbcUwEyNbRDMwJ9b6DCuddWOB2lH5xsD
        tDeftCDtavveDPysKSmXYw2cPYKzZFsNRktOMp12Wn9Ur9YolFHKBCaejrCwZi6ZTknPiDpu
        NHki6Yg81uT0UBksz9Mxh5LsVqeDi8i18o5kmrMZTDalwhbNs2beacmJzraaE5UKRazaozxv
        yl1YWcNtE6H5kz8/oCLk2l6Kgkmg4qBjeQQrRSGkmOpCUNX7nhCKFQS1VZWBQvEDwfPPc4Fb
        luXemQDhoRvB47Zbfv8qgv7mIcyrCqTkMLrRTnhxOHUKZlsGfBijDsBG3xjuxWGUHsYGr3p4
        ksSpSOisN3lpEcXAZs81f9g+eNDW5+sP1CwB7v7pIK8eqBRoaEoUNGEwP/QkSMBSWF3q9nt5
        cN0vDxK8xQimmpv8IhUsfWvFvH0wSgaPnsUI9H5wbdQj4Zs7YOn7dUKIEsG1ErEgoWFxshgX
        MMC76RuEgLXQ1Dzss4opHbhcblSG9tT+C7iLUAvaxdl4cw7HK22q/5fUjnxnJI/vQm1v0t2I
        IhG9XcSUntCJCTaPLzC7EZAYHS6ayPNQIgNbcImzW/V2p4nj3UjtmV05Jt2ZbfUcpcWhV6pj
        VSoVE6eJ16hVtETUuMboxFQO6+AucJyNs2/5AshgaRGKmxhO60kg8Eql62NbxTFpanlmJ1Y4
        5z44M7Iuq+vpKOQKzVnyy2n3Wj9VN3wttieHSt7Kl42LKycftGdpRmNQfmpY33h3fsFug+7h
        uUn69o112cXMhbyEkteu35sVV5jI2uKQM/l3Sl7tVtV0VWoGo2RHqiVzBV8kNbGRvZ1GGudz
        WaUcs/PsX0zxzY5cAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKJMWRmVeSWpSXmKPExsWy7bCSnG7JVK9Yg7szDSwmXN7OaPF3zjsm
        i0c3f7NaHPnfz+jA4rFz1l12jxuvFjJ59G1ZxejxeZNcAEsUl01Kak5mWWqRvl0CV8brTz9Y
        Cu7xVzz4fo2xgXEnTxcjJ4eEgInE+/1PmLoYuTiEBHYzSmxs38AMkZCQeLTzC0sXIweQLSxx
        +HAxRM1HRokni1vZQWrYBLQkbvzexApiiwiESKy6dwfMZhbQkPh94CZYr7BArMT+BSYgJouA
        qsT2uTkgFbwCFhJ/9nWwQWySl1i94QDzBEaeBYwMqxglUwuKc9Nziw0LjPJSy/WKE3OLS/PS
        9ZLzczcxggNDS2sH44kT8YcYBTgYlXh4Lbo8Y4VYE8uKK3MPMUpwMCuJ8N4rAwrxpiRWVqUW
        5ccXleakFh9ilOZgURLnlc8/FikkkJ5YkpqdmlqQWgSTZeLglGpgrFCMPuIUdfRwSSzLTuny
        zgOxhY6qS13/VZ5ZMXNztfvy/25VPmdezNxaZve5PbBnevCE7zNPXIttD/56krmlPsLVLOPV
        ncV+18JeBgsGNtXIbd7ec+i1nWL0DX3x8hr/N2/ZeLSTFb4LntB5VsElmaLFYG4tz3koo0qu
        +eJpmTyfT4+2TjZXYinOSDTUYi4qTgQA2Sh3NQgCAAA=
X-CMS-MailID: 20190807091012epcas1p2d949c05b6dafb0a22f6babe13c5ae9c8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190807091012epcas1p2d949c05b6dafb0a22f6babe13c5ae9c8
References: <CGME20190807091012epcas1p2d949c05b6dafb0a22f6babe13c5ae9c8@epcas1p2.samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Display secure removal type when printing Extended CSD
Example:
	# mmc extcsd read /dev/mmcblk0
	...
	Secure Removal Type [SECURE_REMOVAL_TYPE]: 0x39
	 information removed using a vendor defined

Signed-off-by: Jungseung Lee <js07.lee@samsung.com>
---
 mmc.h      |  3 +++
 mmc_cmds.c | 19 +++++++++++++++++++
 2 files changed, 22 insertions(+)

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
index 19a9da1..8d6455e 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -1766,6 +1766,25 @@ int do_read_extcsd(int nargs, char **argv)
 			ext_csd[EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_B]);
 		printf("eMMC Pre EOL information [EXT_CSD_PRE_EOL_INFO]: 0x%02x\n",
 			ext_csd[EXT_CSD_PRE_EOL_INFO]);
+		reg = ext_csd[EXT_CSD_SECURE_REMOVAL_TYPE];
+		printf("Secure Removal Type [SECURE_REMOVAL_TYPE]: 0x%02x\n", reg);
+		printf(" information removed ");
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
 	}
 
 	if (ext_csd_rev >= 8) {
-- 
2.17.1

