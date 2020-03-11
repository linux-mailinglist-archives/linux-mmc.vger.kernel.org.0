Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6F1F18128F
	for <lists+linux-mmc@lfdr.de>; Wed, 11 Mar 2020 09:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgCKIEl (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 11 Mar 2020 04:04:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:58518 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726198AbgCKIEl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 11 Mar 2020 04:04:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 30A03AC69;
        Wed, 11 Mar 2020 08:04:40 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org
Subject: [PATCH] mmc: vub300: Use scnprintf() for avoiding potential buffer overflow
Date:   Wed, 11 Mar 2020 09:04:39 +0100
Message-Id: <20200311080439.13928-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Since snprintf() returns the would-be-output size instead of the
actual output size, the succeeding calls may go beyond the given
buffer limit.  Fix it by replacing with scnprintf().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/mmc/host/vub300.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index 6ced1b7f642f..4008871bc2ec 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -1363,7 +1363,7 @@ static void download_offload_pseudocode(struct vub300_mmc_host *vub300)
 	int retval;
 	for (n = 0; n < sdio_funcs; n++) {
 		struct sdio_func *sf = card->sdio_func[n];
-		l += snprintf(vub300->vub_name + l,
+		l += scnprintf(vub300->vub_name + l,
 			      sizeof(vub300->vub_name) - l, "_%04X%04X",
 			      sf->vendor, sf->device);
 	}
-- 
2.16.4

