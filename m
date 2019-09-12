Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE73FB15AA
	for <lists+linux-mmc@lfdr.de>; Thu, 12 Sep 2019 23:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbfILVGI (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 12 Sep 2019 17:06:08 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.20]:32056 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728158AbfILVGI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Sep 2019 17:06:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1568322367;
        s=strato-dkim-0002; d=heimpold.de;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=Mi1lP9vRc/aLKH9/n4xIdI/HXW4LRzD1v7CFSpx+60U=;
        b=Ye/CzkbtfKzIjHpewklTrL8weQ/tJ1ZCx1eu191LYLNnoaZQq7Men8oSBePJNmmPvv
        V67nXT91290qAu4XfZfLccSLVDQ1MHbzL+6U99ZR/Q2PgxrhEedybIMrHjt6sEjqHENz
        fIJTFuwLHXsoOyA4XtHxOUrST12Atwq4uVKrW2Jz9SFU/ZdbeXEvVd5aLUPmBvpmJFFt
        mnO355OgAXZ04LUP9cMXSMNbvlC6etlXrmF00Ju733QjN+W/Pi/6TF5/FWyj1nj14F31
        u+dS7sEe8EXlEq/tfB69C8BCyu3ApUnhUVdv+oXsbSIZo1HBMM92mnuOCsjNO/zRR0q2
        RGTw==
X-RZG-AUTH: ":O2kGeEG7b/pS1EW8QnKjhhg/vO4pzqdNytq77N6ZKUSN7PfdWTGQORRBv+ASfYPl1MuRNIWka+y/+PT9jgm56Hi0Pw27ZIWQ+TEC"
X-RZG-CLASS-ID: mo00
Received: from tonne.mhei.heimpold.itr
        by smtp.strato.de (RZmta 44.27.0 AUTH)
        with ESMTPSA id 601202v8CL66d62
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 12 Sep 2019 23:06:06 +0200 (CEST)
Received: from kerker.mhei.heimpold.itr (kerker.mhei.heimpold.itr [192.168.8.1])
        by tonne.mhei.heimpold.itr (Postfix) with ESMTP id 00F5E1407DF;
        Thu, 12 Sep 2019 23:06:06 +0200 (CEST)
From:   Michael Heimpold <mhei@heimpold.de>
To:     chris@printf.net
Cc:     linux-mmc@vger.kernel.org,
        Michael Heimpold <michael.heimpold@i2se.com>,
        Michael Heimpold <mhei@heimpold.de>
Subject: [PATCH mmc-utils v2 1/5] Check calloc's return value before using the pointer
Date:   Thu, 12 Sep 2019 23:05:05 +0200
Message-Id: <20190912210509.19816-2-mhei@heimpold.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190912210509.19816-1-mhei@heimpold.de>
References: <20190912210509.19816-1-mhei@heimpold.de>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Michael Heimpold <michael.heimpold@i2se.com>

If calloc fails, bail out immediately instead of trying to
use the NULL pointer.

Signed-off-by: Michael Heimpold <michael.heimpold@i2se.com>
Cc: Michael Heimpold <mhei@heimpold.de>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
---
 lsmmc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lsmmc.c b/lsmmc.c
index 9737b37..e514c83 100644
--- a/lsmmc.c
+++ b/lsmmc.c
@@ -374,6 +374,8 @@ char *to_binstr(char *hexstr)
 	char *binstr;
 
 	binstr = calloc(strlen(hexstr) * 4 + 1, sizeof(char));
+	if (!binstr)
+		return NULL;
 
 	while (hexstr && *hexstr != '\0') {
 		if (!isxdigit(*hexstr))
-- 
2.17.1

