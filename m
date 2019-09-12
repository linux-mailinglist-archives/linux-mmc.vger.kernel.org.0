Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC16B15BF
	for <lists+linux-mmc@lfdr.de>; Thu, 12 Sep 2019 23:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbfILVMM (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 12 Sep 2019 17:12:12 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:35137 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbfILVMM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Sep 2019 17:12:12 -0400
X-Greylist: delayed 370 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Sep 2019 17:12:11 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1568322730;
        s=strato-dkim-0002; d=heimpold.de;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=jgYyn4jQX9/p+J52AcewZ/hosJDJMQL4mbO+XVvuLE0=;
        b=WA8Xl7P3JxuJXLFm8AE1GZ7YjTaZRyO3agOSWJTqfDouhUDSZUk3ffQLMpzF7E2+Vg
        MRCOJtDfnnm8ogGiKVfB19sP6Ek1S77xN+fU9Y033+pkBlnHs4x2I5AItX5SfAVXOU5y
        SBu/D0/O5AmrnAJ8SkY0lKpcSneocCtmXALEj7OkaaJ5nqQEyUg+bh0WWUAZT7y445Iq
        ab7Cs0pXcO4/Dcq2RFGfFue/f1Y7QplD3Cv5yp++Et1jDDpKdSM1VIHNNt0xTomtjJar
        BBk9y/iYT9I1GQWJa/wimO4dcM/LYLoAx1Hb/vFbPU7trGDAVWjLcER8CDqiyWZP6xe7
        q3Pg==
X-RZG-AUTH: ":O2kGeEG7b/pS1EW8QnKjhhg/vO4pzqdNytq77N6ZKUSN7PfdWTGQORRBv+ASfYPl1MuRNIWka+y/+PT9jgm56Hi0Pw27ZIWQ+TEC"
X-RZG-CLASS-ID: mo00
Received: from tonne.mhei.heimpold.itr
        by smtp.strato.de (RZmta 44.27.0 AUTH)
        with ESMTPSA id 601202v8CL67d63
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 12 Sep 2019 23:06:07 +0200 (CEST)
Received: from kerker.mhei.heimpold.itr (kerker.mhei.heimpold.itr [192.168.8.1])
        by tonne.mhei.heimpold.itr (Postfix) with ESMTP id 16622140D37;
        Thu, 12 Sep 2019 23:06:06 +0200 (CEST)
From:   Michael Heimpold <mhei@heimpold.de>
To:     chris@printf.net
Cc:     linux-mmc@vger.kernel.org,
        Michael Heimpold <michael.heimpold@i2se.com>,
        Michael Heimpold <mhei@heimpold.de>
Subject: [PATCH mmc-utils v2 2/5] Cleanup memory in error case
Date:   Thu, 12 Sep 2019 23:05:06 +0200
Message-Id: <20190912210509.19816-3-mhei@heimpold.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190912210509.19816-1-mhei@heimpold.de>
References: <20190912210509.19816-1-mhei@heimpold.de>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Michael Heimpold <michael.heimpold@i2se.com>

In case that we leave due to malformed string,
free the allocated memory before returning.

Signed-off-by: Michael Heimpold <michael.heimpold@i2se.com>
Cc: Michael Heimpold <mhei@heimpold.de>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
---
 lsmmc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lsmmc.c b/lsmmc.c
index e514c83..a53bc57 100644
--- a/lsmmc.c
+++ b/lsmmc.c
@@ -378,8 +378,10 @@ char *to_binstr(char *hexstr)
 		return NULL;
 
 	while (hexstr && *hexstr != '\0') {
-		if (!isxdigit(*hexstr))
+		if (!isxdigit(*hexstr)) {
+			free(binstr);
 			return NULL;
+		}
 
 		if (isdigit(*hexstr))
 			strcat(binstr, bindigits[*hexstr - '0']);
-- 
2.17.1

