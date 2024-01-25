Return-Path: <linux-mmc+bounces-713-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 853C083C4EB
	for <lists+linux-mmc@lfdr.de>; Thu, 25 Jan 2024 15:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6B73B251E1
	for <lists+linux-mmc@lfdr.de>; Thu, 25 Jan 2024 14:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877016EB68;
	Thu, 25 Jan 2024 14:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SGD+fkCN"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24626EB59
	for <linux-mmc@vger.kernel.org>; Thu, 25 Jan 2024 14:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706193437; cv=none; b=M1rkG9oaxSVRLsrdclemdyB9L9gr5CmsB8FCL+YXQN8qmw0SsjY7hbT9VD2T2BfWY4ytvEtfFR5m6ufNaY26IkdDKSVA/wctBX9VzrSkPIHuKrzOaPydBnXy+NLWkYg+b8ycYtpNZIpbgV1SBfl3ktdE2r+7haPbjDjiV06gTWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706193437; c=relaxed/simple;
	bh=dUmbPvU0C8VRoo9iWbxEG6uM01EkIK75bcOiAdjB25w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nwBo+FlAOEab3aa/nY+gUb+mii2o+J4qOlQdBl+9jd0haQ4P3F9R1C3BRKrpx8lMNsz95rNiq7T+qCts+5RhPMzuYNA4kbGxLNOem2CHRJ+BNC3zXInM6/Fe8+JVcNnN37z1ds5/snmULvf0lbl+EwBSHHgKz222LK+YEDX5Ew4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SGD+fkCN; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2cf3a04ea1cso8043881fa.2
        for <linux-mmc@vger.kernel.org>; Thu, 25 Jan 2024 06:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706193433; x=1706798233; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0p/ZF4Qoyc/L5BPHTulDTqASzKK4BbFP5+9sQzchQas=;
        b=SGD+fkCNkm4T6il7tamKcdiyYox6b0VQ97GEy+Vea2PwX2YV8H+2S5MD92XUqO4FTS
         L0YVT59MZ8Tcl5jvSthxmT5ZAQg9ZPB2WalQxkUMxUspNNh7vPnj4ZTEmnjthCNPQEba
         iZNWa8rP7G66oEcejUqJk5TKV6hRQgdnZGwTFC+SvNrPZENEHKCNzuTA7cUqJCiVUNBM
         TOc+OWM1A8E/RsLwQivMRZPgNks3xylmsnrfL+9l5SgImVm3p0lMGG705MZHPg0dSMuF
         o+qAMw/ax098kNIJpRsWaLITgOPx8LU5n7vmuVkQ0+gPUZJvLyQ8Lo00/XY/CbV9YIf3
         7uKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706193433; x=1706798233;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0p/ZF4Qoyc/L5BPHTulDTqASzKK4BbFP5+9sQzchQas=;
        b=uZPMBG+nEONkJlEHWCPvUdN9tXIOHFBKVH3KFJ+fGg8ZcdG+2k5B4zS6ZJmw1UX3hX
         tjG8dLMyxytP83rw/z6pwXqclUY1D+MT4kq+WxfIaZO6Eglme7sGnxpjZe3ien70fKx8
         16e69qSt+0Gr2KcjvYljbbfVl4W09xogozq7ESQhADwa+Vvg02h0rE9a2cRtvPA5oCVA
         FxfoMSqI24CcQ/AibOaujfGUDMNK3zinvmoM4a0fYfEgEnH0G7sOuKqxnJKVRGpEtIaB
         8uWre2Cbk5k3YGaF1wcVaTZA8VLvwk5XmDh+JKcy0tUSvOyNwwodmTjbDjfs9XRXLyMN
         Y79A==
X-Gm-Message-State: AOJu0YyJRVZ72T4h0zeFjInGbypb1nEVWDnDr7AKQOS6ilIPafNTBdzl
	LECYZhft5yL/Qe9gHjVJLxTWN5n8BXfUZb6zYwbCGlPYzbs33gDdbQ/oREp/v30=
X-Google-Smtp-Source: AGHT+IE2j/hx+TjW/VFSr9+UBY3Hbz0FN2hxOgkz7PQpgoay1lOTJOQqMnIpUCN7BuM5xSBcSZQTKg==
X-Received: by 2002:a2e:995a:0:b0:2cf:1c41:39bb with SMTP id r26-20020a2e995a000000b002cf1c4139bbmr731800ljj.69.1706193433640;
        Thu, 25 Jan 2024 06:37:13 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id y24-20020a2e3218000000b002ce098d3f0asm292644ljy.115.2024.01.25.06.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 06:37:13 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 25 Jan 2024 15:37:11 +0100
Subject: [PATCH 7/7] mmc: sh_mmcif: Map the virtual page for PIO
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-mmc-proper-kmap-v1-7-ba953c1ac3f9@linaro.org>
References: <20240125-mmc-proper-kmap-v1-0-ba953c1ac3f9@linaro.org>
In-Reply-To: <20240125-mmc-proper-kmap-v1-0-ba953c1ac3f9@linaro.org>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
 Ming Lei <ming.lei@redhat.com>, Arnd Bergmann <arnd@arndb.de>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Nicolas Pitre <nico@fluxnic.net>, 
 Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Angelo Dureghello <angelo.dureghello@timesys.com>
Cc: linux-mmc@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4

Use kmap_local_page() instead of sg_virt() to obtain a page
from the scatterlist: sg_virt() will not perform bounce
buffering if the page happens to be located in high memory,
which the driver may or may not be using.

This code is a bit asynchronous due to being called
repeatedly from an interrupt handler, so it would be great
if someone can test this.

Suggested-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/linux-mmc/20240122073423.GA25859@lst.de/
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/sh_mmcif.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 077d711e964e..f9f56d653ff4 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -611,13 +611,27 @@ static bool sh_mmcif_next_block(struct sh_mmcif_host *host, u32 *p)
 
 	if (host->sg_blkidx == data->sg->length) {
 		host->sg_blkidx = 0;
+		/* Unmap previous sg and map the next one */
+		if (host->pio_ptr) {
+			kunmap_local(host->pio_ptr);
+			host->pio_ptr = NULL;
+		}
 		if (++host->sg_idx < data->sg_len)
-			host->pio_ptr = sg_virt(++data->sg);
+			host->pio_ptr = kmap_local_page(sg_page(++data->sg));
 	} else {
 		host->pio_ptr = p;
 	}
 
-	return host->sg_idx != data->sg_len;
+	/*
+	 * We return true of there are more blocks, and false if there is no
+	 * next block.
+	 */
+	if (host->sg_idx != data->sg_len)
+		return true;
+	/* Unmap the last buffer if any */
+	if (host->pio_ptr)
+		kunmap_local(host->pio_ptr);
+	return false;
 }
 
 static void sh_mmcif_single_read(struct sh_mmcif_host *host,
@@ -669,7 +683,7 @@ static void sh_mmcif_multi_read(struct sh_mmcif_host *host,
 	host->wait_for = MMCIF_WAIT_FOR_MREAD;
 	host->sg_idx = 0;
 	host->sg_blkidx = 0;
-	host->pio_ptr = sg_virt(data->sg);
+	host->pio_ptr = kmap_local_page(sg_page(data->sg));
 
 	sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MBUFREN);
 }
@@ -749,7 +763,7 @@ static void sh_mmcif_multi_write(struct sh_mmcif_host *host,
 	host->wait_for = MMCIF_WAIT_FOR_MWRITE;
 	host->sg_idx = 0;
 	host->sg_blkidx = 0;
-	host->pio_ptr = sg_virt(data->sg);
+	host->pio_ptr = kmap_local_page(sg_page(data->sg));
 
 	sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MBUFWEN);
 }

-- 
2.34.1


