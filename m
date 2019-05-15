Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7B81F53D
	for <lists+linux-mmc@lfdr.de>; Wed, 15 May 2019 15:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbfEONOv (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 15 May 2019 09:14:51 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:42842 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbfEONOv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 May 2019 09:14:51 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4FDEYE5098121;
        Wed, 15 May 2019 13:14:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2018-07-02; bh=0DM8Zd/vrI5DngyCF4cDMV1bvR8ByAC+SJiy59iXGdU=;
 b=UDJwuWe6GzN/hxoJ1yY3K3fVGNwGMX98k6CqjToCOyjDmC3VkKmt4TBVYbvtRso8DhbE
 +H6cdxzNYPJ20RMvgbcuT9UYCitCTX3W2yzFmv28oS44ia0VA0bZdH1DuwiZ0dPhf9mY
 8BhwoQRhmrx+NE9aOef++YJRQZGZPSpgtzjgPYmHQzlvvCS8RUgedcVaRw20f3e0RCEi
 gAjvDV3ZTm9kM324q9XGsSlRL3m7+82w+sBKXSRZ5Em69YrNqgrWzckR6BHCchFvQ3TU
 2Tt2pU7MT4JIqZEQjW/fIoc1EiJKeqRLhCSPJNpww/o/u0s6TlWztpbrNngOuylH8zaq WA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 2sdkwdvvfm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 May 2019 13:14:45 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4FDDLY4079773;
        Wed, 15 May 2019 13:14:45 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2sgk76ga31-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 May 2019 13:14:45 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4FDEhBX017295;
        Wed, 15 May 2019 13:14:43 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 15 May 2019 06:14:42 -0700
Date:   Wed, 15 May 2019 16:14:34 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH v2] mmc: tegra: Fix a warning message
Message-ID: <20190515131434.GA18205@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFpm9dB55aCUQkDHgyfcJdniNG9jCbdQ4ezYgQ=L8Rxfhw@mail.gmail.com>
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9257 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905150084
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9257 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905150085
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The WARN_ON() macro takes a condition, not a warning message.  Really,
this should probably be dev_warn_once().

Fixes: ea8fc5953e8b ("mmc: tegra: update hw tuning process")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v2: Use dev_warn_once()

 drivers/mmc/host/sdhci-tegra.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index f608417ae967..fc07970acaf5 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -865,7 +865,8 @@ static void tegra_sdhci_tap_correction(struct sdhci_host *host, u8 thd_up,
 	}
 
 	if (!first_fail) {
-		WARN_ON("no edge detected, continue with hw tuned delay.\n");
+		dev_warn_once(mmc_dev(host->mmc),
+			      "no edge detected, continue with hw tuned delay.\n");
 	} else if (first_pass) {
 		/* set tap location at fixed tap relative to the first edge */
 		edge1 = first_fail_tap + (first_pass_tap - first_fail_tap) / 2;
-- 
2.20.1

