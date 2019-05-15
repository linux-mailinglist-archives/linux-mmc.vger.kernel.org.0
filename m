Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3AAB1EB01
	for <lists+linux-mmc@lfdr.de>; Wed, 15 May 2019 11:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbfEOJfa (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 15 May 2019 05:35:30 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44818 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfEOJf3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 May 2019 05:35:29 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4F9Ok9c107630;
        Wed, 15 May 2019 09:35:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=DTLu+306jeoQ71JC0Verk/5lk+Fahjkf4IY4TjYIpB8=;
 b=zZYz42jdhC+iqrGWnQGaT5ExLVwSjdyHIJE5gWbydr7zqW/UzZu3x1mpMzr3S3lIJWVL
 sEQRPopZdUInLckNpwWfR9RqOns4zwkaTVPXPKdrMpK6487mmEfUpkwMtVD2H0Foqxd7
 WIVR7WbiemdWGpHZebIJldLKZY1a+5mLhuWjKTPFY9TnN69Mbiv1Ps80KgHpGIShqWII
 hZHSSJiuLMTE8foi3bLY9r7FbgcSjKSLtpFJ77ZajcUK+F5Uwp7y5tEeNXGCnwZra//V
 IP20zqLMnS7IpW1L4gVd9TC380psfoTR1u2l3orN5bUJaTRqrnpGPZkGd3BMlKsV3y6I nw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2sdq1qkgx8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 May 2019 09:35:25 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4F9ZJUd148809;
        Wed, 15 May 2019 09:35:24 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2sdmebmuka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 May 2019 09:35:24 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4F9ZNE5028224;
        Wed, 15 May 2019 09:35:23 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 15 May 2019 02:35:23 -0700
Date:   Wed, 15 May 2019 12:35:14 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] mmc: tegra: Fix a warning message
Message-ID: <20190515093512.GD3409@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9257 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905150061
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9257 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905150061
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The WARN_ON() macro takes a condition, not a warning message.  I've
changed this to use WARN(1, "msg...

Fixes: ea8fc5953e8b ("mmc: tegra: update hw tuning process")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/mmc/host/sdhci-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index f608417ae967..10d7aaf68bab 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -865,7 +865,7 @@ static void tegra_sdhci_tap_correction(struct sdhci_host *host, u8 thd_up,
 	}
 
 	if (!first_fail) {
-		WARN_ON("no edge detected, continue with hw tuned delay.\n");
+		WARN(1, "no edge detected, continue with hw tuned delay.\n");
 	} else if (first_pass) {
 		/* set tap location at fixed tap relative to the first edge */
 		edge1 = first_fail_tap + (first_pass_tap - first_fail_tap) / 2;
-- 
2.20.1

