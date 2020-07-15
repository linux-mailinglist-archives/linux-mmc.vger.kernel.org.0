Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC09220649
	for <lists+linux-mmc@lfdr.de>; Wed, 15 Jul 2020 09:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbgGOHe3 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 15 Jul 2020 03:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729076AbgGOHe2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jul 2020 03:34:28 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA0EC061755;
        Wed, 15 Jul 2020 00:34:28 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id l63so2641390pge.12;
        Wed, 15 Jul 2020 00:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L4Upa5Ox6eYKMHWbl0x+zX//u1+K2pCyN/VejEUmz+k=;
        b=TRfbOB/dBflHu8CS9n2jVbSBFRrUBCO72r0acgGxA4HqDK5hf3URNTj8cElClrAUgb
         oPx9BnLBrOkF7BI3Ee5UO+AyIgr9lcgAo8GNulXIXhaiRRbophfWgPXAlWWvdQDfSky1
         B3baXQmTERj9o2a0MqFVYveEy9AKuL8N8Gwc9yQyzFJBlK9Lu4U+pBl6Or/lvju4pzvJ
         6MwLj4n9gxaX0omE5+cvZclpZeAAoEKvXPgw0U02sQdcSCG8PagoUKkcgJffibhAZ46w
         /wJDl5GUNGRwlI+IB7S2U8ZjfpfXVF/Lf93YPIzoSdNBqkL8SDq7XqgJLVoP/nb2whhZ
         MMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L4Upa5Ox6eYKMHWbl0x+zX//u1+K2pCyN/VejEUmz+k=;
        b=m3olRCpagHsDjzj3aJp5wN2NJYHTgn6TT52wiVRJynaFme4Y3iOoJ6yXHm2HQ6RNvY
         FsGVZwQIQpmOtcQHPKVkVIWXWCdFhREffowNLPC5iYcKxikFnZB5n7P0Gds5pBtcGObb
         aPB5lGoQqKchm3LZe0MBKv8Ou9aId7zTM6HhvTwUU60jqicQuuRz34b4/gmLv3MmVxhK
         YVnA02wpD+zUZ/MN9XQWO8asH3vxeb6GZXI4fhJ/Pv4PAiUpfPhn38Adq68sifBRGwUF
         aleOg+RMRretZlwpIZTHAyXTAVfwSf1CLQI0rpuEkG50kln4Kac5tkHHZrO4BtzG+5qP
         U30Q==
X-Gm-Message-State: AOAM532s/D1ATNlysqD2rFyF8xjcXk01hET3xk1gy4KOgvAV9dPqhSze
        AObC5CK/0fcAa4DXWmjMML4=
X-Google-Smtp-Source: ABdhPJwUTGQq5AMlMHcccxwqlUWbtQ0Nr5ko9Esrvmj9x4/VdVjKM4CVkGnlWyjGT3FTRhpqMsb/oA==
X-Received: by 2002:a62:4ec5:: with SMTP id c188mr8019190pfb.199.1594798468069;
        Wed, 15 Jul 2020 00:34:28 -0700 (PDT)
Received: from gli-arch.genesyslogic.com.tw ([122.146.30.3])
        by smtp.gmail.com with ESMTPSA id y18sm1210188pff.10.2020.07.15.00.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 00:34:27 -0700 (PDT)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, riteshh@codeaurora.org,
        asutoshd@codeaurora.org, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ben Chuang <benchuanggli@gmail.com>
Subject: [PATCH] mmc: cqhci: Fix a print format for the task descriptor
Date:   Wed, 15 Jul 2020 15:33:44 +0800
Message-Id: <20200715073344.8965-1-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The format string of the task descriptor should be "%016llx".

Signed-off-by: Ben Chuang <benchuanggli@gmail.com>
---
 drivers/mmc/host/cqhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
index 75934f3c117e..280d64d0b809 100644
--- a/drivers/mmc/host/cqhci.c
+++ b/drivers/mmc/host/cqhci.c
@@ -422,7 +422,7 @@ static void cqhci_prep_task_desc(struct mmc_request *mrq,
 		CQHCI_BLK_COUNT(mrq->data->blocks) |
 		CQHCI_BLK_ADDR((u64)mrq->data->blk_addr);
 
-	pr_debug("%s: cqhci: tag %d task descriptor 0x016%llx\n",
+	pr_debug("%s: cqhci: tag %d task descriptor 0x%016llx\n",
 		 mmc_hostname(mrq->host), mrq->tag, (unsigned long long)*data);
 }
 
-- 
2.27.0

