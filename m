Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 163CA25629D
	for <lists+linux-mmc@lfdr.de>; Fri, 28 Aug 2020 23:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgH1Vs7 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 28 Aug 2020 17:48:59 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:41343 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgH1Vs5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Aug 2020 17:48:57 -0400
Received: from localhost.localdomain ([37.4.249.236]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MzQTm-1kXpKC3Jq4-00vObT; Fri, 28 Aug 2020 23:48:40 +0200
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Matthias Brugger <mbrugger@suse.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH] mmc: sdhci-iproc: Enable eMMC DDR 3.3V support for bcm2711
Date:   Fri, 28 Aug 2020 23:47:14 +0200
Message-Id: <1598651234-29826-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:kiziRvARXQvcShivifQ3e8jFQc5NDvS/jk5DcBO1+kY24pjuxcW
 pNMzHbKjpwEkD+6H3B4dmClTpiU+4kjeXUo3zfO/VqTahci/RQgw2Jjg5ClfAO20vRj4cmp
 eqHXUd9TKy5yr6xa9AzDep/tDWw/ZAMYe72C6NEC+QVodXdoe7JDC+duHvIEy7khM7PY+GF
 NzqIu6pdSVbj1v16NZ+sA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:eelQECZEP/o=:AtkwbFez+YK2lUaKrnCAex
 dIlTU0COpkkpKB5Qb0bMKrb8/w/SPJ2rMBPQOKwEd9/tUzoKWo+ZbAPQPpEnEcUM5QKbnzw+7
 qB1kFvhlFgAjX6S2VYE4TsPxy/Dk93b1KLbB3TpK4iOUqvcYMDP11kGtwphrPqzjB+yWqwO6y
 KgxT+VLe4SNkCYaD9JES6M1Hj770HNy3DMUeor3ZbWVQqJsm02Xd9jnX8ThCwNQM0x9NSolVQ
 25RoD6I8fehNYcceOQKKGQTSKFw5NMv66cwKfnVYhvG9mj1Fix4xF1ssUx+PIaAKz9IPtf88l
 ls9Dj7R5z6+Jfpg2yCxV8pPeg1/NewyDH1Bmv2XVIVVZa3o3Ffms2jaDcGuRIJzYvAGzwhj+z
 G+spv31CNuWsBbUeimVwPoWruWAapA+EIOp57iNo95TYAamLRoBF+aIc4DiCyoVKiHvWl7mOh
 iDs2nI+sgIn+GWEfuSGJNNmNXiOSRr8PyVRuQELwCvbnkr1JmZqzYOdiYlIdE60pjRs0VVnSZ
 xYhbUBsbEC/lXnNUb5fF1o3qlK742HPj1nJQ3lQOdh1rcqOG20kRgACUeVAbq1NMG3DNsuHRS
 xsYTKTMMWPPeSrsGrGwEWQurcjWiskZ8QvmiCkaJHzyxpEWZfmqH30xnyIVdeVakqbob0ddv6
 VLEnvtryHj/lA4fHtioyBJ4A5CpKR2At7wnlKOICKyaHniUfMlssMuxexvZkbh5Tk/TR7aW7A
 krPi5wigbGYz2Pf0BiIjJOix9EDYS3+e2oyn6oFZX2gJcfDBT48tMcVYK3IOk6vnwvvmszY/k
 jexjMPuNFqHptYGNN/TyrXxKulWcZQdCYcksDfKHCrY0TIrxu44YkbhUl22nDy4LRXZQU6h
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The emmc2 interface on the bcm2711 supports DDR modes for eMMC devices
running at 3.3V. This allows to run eMMC module with 3.3V signaling voltage
at DDR52 mode on the Raspberry Pi 4 using a SD adapter:

  clock: 52000000 Hz
  actual clock: 50000000 Hz
  vdd: 21 (3.3 ~ 3.4 V)
  bus mode: 2 (push-pull)
  chip select: 0 (don't care)
  power mode: 2 (on)
  bus width: 2 (4 bits)
  timing spec: 8 (mmc DDR52)
  signal voltage: 0 (3.30 V)
  driver type: 0 (driver type B)

Link: https://github.com/raspberrypi/linux/issues/3802
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/mmc/host/sdhci-iproc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
index e2d8dfe..b540aa6 100644
--- a/drivers/mmc/host/sdhci-iproc.c
+++ b/drivers/mmc/host/sdhci-iproc.c
@@ -283,6 +283,7 @@ static const struct sdhci_pltfm_data sdhci_bcm2711_pltfm_data = {
 
 static const struct sdhci_iproc_data bcm2711_data = {
 	.pdata = &sdhci_bcm2711_pltfm_data,
+	.mmc_caps = MMC_CAP_3_3V_DDR,
 };
 
 static const struct of_device_id sdhci_iproc_of_match[] = {
-- 
2.7.4

