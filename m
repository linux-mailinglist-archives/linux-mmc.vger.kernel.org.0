Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7FAB15C1
	for <lists+linux-mmc@lfdr.de>; Thu, 12 Sep 2019 23:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbfILVMP (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 12 Sep 2019 17:12:15 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:23969 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728360AbfILVMP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Sep 2019 17:12:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1568322733;
        s=strato-dkim-0002; d=heimpold.de;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=tnNocpMSsRlv98k9hado3/fJfcLjPZjaARapiEs10Ow=;
        b=FZBAFl0ULwqFOXpA/V2cQKzNcKAEuGUoj+s7s257PXssEZ9mXH2fYRIdWc5KHp5nr5
        cQCKLDTp+FzKpUyV6xbDoYWWkwxfqslBrxTNATp9UXHyDiMU7Oslf/NLFD6RoFV4t/cp
        RGqqM1X0zrP41HznlVZzKAScvrThU41c7ADAtapjv489QuxmHq4yPbF3a9glsEa9OiJT
        ODX4ah1aLhBjHcuX9whDw5gUpCiobRr+NJcNShPIW+q0X0yeCRSxjKpfcHM+XfC2oV3U
        gVIKqEywbWyl56zlj0P3izf2dVUgNWl+vJdJ8LCywTc9BE/yBThfCtJFwgHJPlNhpP2t
        2kEQ==
X-RZG-AUTH: ":O2kGeEG7b/pS1EW8QnKjhhg/vO4pzqdNytq77N6ZKUSN7PfdWTGTOWHr182H3hxoqa1Ifw=="
X-RZG-CLASS-ID: mo00
Received: from tonne.mhei.heimpold.itr
        by smtp.strato.de (RZmta 44.27.0 DYNA|AUTH)
        with ESMTPSA id 601202v8CL67d66
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 12 Sep 2019 23:06:07 +0200 (CEST)
Received: from kerker.mhei.heimpold.itr (kerker.mhei.heimpold.itr [192.168.8.1])
        by tonne.mhei.heimpold.itr (Postfix) with ESMTP id 4F837141348;
        Thu, 12 Sep 2019 23:06:06 +0200 (CEST)
From:   Michael Heimpold <mhei@heimpold.de>
To:     chris@printf.net
Cc:     linux-mmc@vger.kernel.org,
        Michael Heimpold <michael.heimpold@i2se.com>,
        Michael Heimpold <mhei@heimpold.de>
Subject: [PATCH mmc-utils v2 5/5] Add eMMC vendor Micron to table
Date:   Thu, 12 Sep 2019 23:05:09 +0200
Message-Id: <20190912210509.19816-6-mhei@heimpold.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190912210509.19816-1-mhei@heimpold.de>
References: <20190912210509.19816-1-mhei@heimpold.de>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Michael Heimpold <michael.heimpold@i2se.com>

Signed-off-by: Michael Heimpold <michael.heimpold@i2se.com>
Cc: Michael Heimpold <mhei@heimpold.de>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
---
 lsmmc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lsmmc.c b/lsmmc.c
index 86713f7..4f687ac 100644
--- a/lsmmc.c
+++ b/lsmmc.c
@@ -194,6 +194,11 @@ struct ids_database database[] = {
 		.id = 0x11,
 		.manufacturer = "Toshiba",
 	},
+	{
+		.type = "mmc",
+		.id = 0x13,
+		.manufacturer = "Micron",
+	},
 	{
 		.type = "mmc",
 		.id = 0x15,
-- 
2.17.1

