Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D57A5B15C0
	for <lists+linux-mmc@lfdr.de>; Thu, 12 Sep 2019 23:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbfILVMN (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 12 Sep 2019 17:12:13 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.165]:36786 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728360AbfILVMM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Sep 2019 17:12:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1568322731;
        s=strato-dkim-0002; d=heimpold.de;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=W3+ORcgRb3YoR56PvMa7ITKVnTYtWYqLToRTN5etO7I=;
        b=SBcJgZGiElMw1j0PCBVcgzYkkSAG0LKmMi2ZjbkEVUrvEILZ7d9FubkgZ6l0WIrRtV
        pQ7qopa1sGxaMGEky54QLXRMooLhvqX+c9TsxRSo0rMrdMlCwxgv6VyJUHVxdYiwQ8z7
        zat9fZfyB15ZPs6PAc+/1vUEXzpq/k/ZdsqDtuDcJhg+uF7eGEVUAGgGs46lw1pR3910
        66j79KAj1ZFXmVCi/z6itPLpaJeQeBXMrG+jYgLUUAedT+T56jFFTWDswn08GkOjtyNv
        99ZrL7tSw+Frz82wqHWhoRr7deueTHYDf3Nv0sppFzo18Ev1V+3aoYhNchAjaJLF9n89
        EnEw==
X-RZG-AUTH: ":O2kGeEG7b/pS1EW8QnKjhhg/vO4pzqdNytq77N6ZKUSN7PfdWTGQORRBv+ASfYPl1MuRNIWka+y/+PT9jgm56Hi0Pw27ZIWQ+TEC"
X-RZG-CLASS-ID: mo00
Received: from tonne.mhei.heimpold.itr
        by smtp.strato.de (RZmta 44.27.0 AUTH)
        with ESMTPSA id 601202v8CL67d65
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 12 Sep 2019 23:06:07 +0200 (CEST)
Received: from kerker.mhei.heimpold.itr (kerker.mhei.heimpold.itr [192.168.8.1])
        by tonne.mhei.heimpold.itr (Postfix) with ESMTP id 3C4BF140D8E;
        Thu, 12 Sep 2019 23:06:06 +0200 (CEST)
From:   Michael Heimpold <mhei@heimpold.de>
To:     chris@printf.net
Cc:     linux-mmc@vger.kernel.org,
        Michael Heimpold <michael.heimpold@i2se.com>,
        Michael Heimpold <mhei@heimpold.de>
Subject: [PATCH mmc-utils v2 4/5] Optimize to_binstr() function
Date:   Thu, 12 Sep 2019 23:05:08 +0200
Message-Id: <20190912210509.19816-5-mhei@heimpold.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190912210509.19816-1-mhei@heimpold.de>
References: <20190912210509.19816-1-mhei@heimpold.de>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Michael Heimpold <michael.heimpold@i2se.com>

Appending multiple times to same string is slow since strcat() needs
to determine the end during each run. So manually maintain a pointer
to the end to speed-up things.

Signed-off-by: Michael Heimpold <michael.heimpold@i2se.com>
Cc: Michael Heimpold <mhei@heimpold.de>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
---
 lsmmc.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/lsmmc.c b/lsmmc.c
index e64117c..86713f7 100644
--- a/lsmmc.c
+++ b/lsmmc.c
@@ -371,12 +371,14 @@ char *to_binstr(char *hexstr)
 		"0000", "0001", "0010", "0011", "0100", "0101", "0110", "0111",
 		"1000", "1001", "1010", "1011", "1100", "1101", "1110", "1111",
 	};
-	char *binstr;
+	char *binstr, *tail;
 
 	binstr = calloc(strlen(hexstr) * 4 + 1, sizeof(char));
 	if (!binstr)
 		return NULL;
 
+	tail = binstr;
+
 	while (hexstr && *hexstr != '\0') {
 		if (!isxdigit(*hexstr)) {
 			free(binstr);
@@ -384,13 +386,14 @@ char *to_binstr(char *hexstr)
 		}
 
 		if (isdigit(*hexstr))
-			strcat(binstr, bindigits[*hexstr - '0']);
+			strcat(tail, bindigits[*hexstr - '0']);
 		else if (islower(*hexstr))
-			strcat(binstr, bindigits[*hexstr - 'a' + 10]);
+			strcat(tail, bindigits[*hexstr - 'a' + 10]);
 		else
-			strcat(binstr, bindigits[*hexstr - 'A' + 10]);
+			strcat(tail, bindigits[*hexstr - 'A' + 10]);
 
 		hexstr++;
+		tail += 4;
 	}
 
 	return binstr;
-- 
2.17.1

