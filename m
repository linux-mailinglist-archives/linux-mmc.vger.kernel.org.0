Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16EA8B15B3
	for <lists+linux-mmc@lfdr.de>; Thu, 12 Sep 2019 23:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbfILVJM (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 12 Sep 2019 17:09:12 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:17797 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728291AbfILVJM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Sep 2019 17:09:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1568322551;
        s=strato-dkim-0002; d=heimpold.de;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=ch7+MgPL2eqXsrOgRJm70jGgAe32CnK/W2TesRYWmj0=;
        b=beO5k+V6LRRpZBgpbPf9MRZt/87zXy8rx7tkt2amNwt+5Ev4o1bI7KG09PCsh7p0d+
        SVWQJTWOwP/AnVSfsIrpRw9oXjJ8tKH6zKfhzD3KMpocPhisfXRupRmtr+oufsZY3dcK
        /vSoUij5iV9w1QcHY4535Rl/9oUzxewo0tZbzwqwWejwMbnX1Y20YrLgEb9UPyY46QLs
        RJp1fRbJNR/RJO38xJ2GN4WKJu0Z9JwuQHgQfMaKJ0dFB9pO+/LIdQFmzTYKmuY6glhv
        T+2KPXuX06S6nHd0ZHCBEljP22b8+w7p+or7lLeEdmf+6thnLT5EvB704YCHkrZlcxoR
        HX1w==
X-RZG-AUTH: ":O2kGeEG7b/pS1EW8QnKjhhg/vO4pzqdNytq77N6ZKUSN7PfdWTGTOWHr182H3hxoqa1Ifw=="
X-RZG-CLASS-ID: mo00
Received: from tonne.mhei.heimpold.itr
        by smtp.strato.de (RZmta 44.27.0 DYNA|AUTH)
        with ESMTPSA id 601202v8CL67d64
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 12 Sep 2019 23:06:07 +0200 (CEST)
Received: from kerker.mhei.heimpold.itr (kerker.mhei.heimpold.itr [192.168.8.1])
        by tonne.mhei.heimpold.itr (Postfix) with ESMTP id 295B8140D8B;
        Thu, 12 Sep 2019 23:06:06 +0200 (CEST)
From:   Michael Heimpold <mhei@heimpold.de>
To:     chris@printf.net
Cc:     linux-mmc@vger.kernel.org,
        Michael Heimpold <michael.heimpold@i2se.com>,
        Michael Heimpold <mhei@heimpold.de>
Subject: [PATCH mmc-utils v2 3/5] Fix parsing of character in to_binstr()
Date:   Thu, 12 Sep 2019 23:05:07 +0200
Message-Id: <20190912210509.19816-4-mhei@heimpold.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190912210509.19816-1-mhei@heimpold.de>
References: <20190912210509.19816-1-mhei@heimpold.de>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Michael Heimpold <michael.heimpold@i2se.com>

When a hex-digit > 'a' or 'A' is read, we have to add an offset of 10
to access the valid symbol in our mapping table.

Signed-off-by: Michael Heimpold <michael.heimpold@i2se.com>
Cc: Michael Heimpold <mhei@heimpold.de>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
---
 lsmmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lsmmc.c b/lsmmc.c
index a53bc57..e64117c 100644
--- a/lsmmc.c
+++ b/lsmmc.c
@@ -386,9 +386,9 @@ char *to_binstr(char *hexstr)
 		if (isdigit(*hexstr))
 			strcat(binstr, bindigits[*hexstr - '0']);
 		else if (islower(*hexstr))
-			strcat(binstr, bindigits[*hexstr - 'a']);
+			strcat(binstr, bindigits[*hexstr - 'a' + 10]);
 		else
-			strcat(binstr, bindigits[*hexstr - 'A']);
+			strcat(binstr, bindigits[*hexstr - 'A' + 10]);
 
 		hexstr++;
 	}
-- 
2.17.1

