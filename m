Return-Path: <linux-mmc+bounces-708-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 213FE83C4D6
	for <lists+linux-mmc@lfdr.de>; Thu, 25 Jan 2024 15:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0F8A28BCFA
	for <lists+linux-mmc@lfdr.de>; Thu, 25 Jan 2024 14:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C4A6E2D4;
	Thu, 25 Jan 2024 14:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pu6svjJs"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9B86E2C1
	for <linux-mmc@vger.kernel.org>; Thu, 25 Jan 2024 14:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706193432; cv=none; b=Eq87gdv4L/K8c3DnK34KVmNE6IROQo5tsysp8Dvm6nbwDrnLUDc64nxTfheV9XuzzJSM6ffY1w76HeF84VlV3YzwfEDJZEZhqT8KFRCjIhMAZS+zWyngHXiFz+G2Nv+LOdY6cTUw7lDg9TFDNnjbOY4aS9JTwymoQJDI6yMvXpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706193432; c=relaxed/simple;
	bh=GuAK1SrygrJ1Pbwv2s94cKHIzXqnBSS/RN81vD3QUOE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kG+OLO9luF/BzRYlLXF/vlZ4x8qopgA/ydGlyGQXwJmYWPpIkCPngV2G3snSsRodT+DgxrJLuTi6Ck+U97kwBqsBMbSiMYsuIS3HNzj8ihbjP2rUpr4yt7GG3kQTW+X1dHxwdWJDYT9GBvrT6+2q7GkYKUXcw3/g1QSRMysSwzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pu6svjJs; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2cf3ed3b917so4831571fa.1
        for <linux-mmc@vger.kernel.org>; Thu, 25 Jan 2024 06:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706193429; x=1706798229; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+QFZ+mkC4kkjj+4EYDZYr6F/eopGpIChJZt5vmWI1II=;
        b=pu6svjJs3riuHSfGOJ+/eMw9uosRbEXcpJJZnsw51WpGvnVoAdrMMycQIoJvsGCkJH
         Ek0m4cnHYYT7zMtj8hM9t9TFS0CNHYufbF+8BiaVO+L8FxYhm3T18edmU6AgpgxG+Qeu
         nU7qt6CVeb/2O5CJ8T6T7jX/8trC27ycxPpPHtHhWYFZdkv81DieYDPPC2e3BhegzPW3
         oMQK76/e99N6sWgZ1+XBObam9HgPvPLNPBOdsRtCl3NbVlHOYccTfl1VS209lX9pZfjF
         Q9+rpOA0N9gOkqfS1BxQPL/9gshnEz2/USzEIhSMP6qE1wkwXOKbL8NP3nSUv9a1zRxL
         YuXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706193429; x=1706798229;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+QFZ+mkC4kkjj+4EYDZYr6F/eopGpIChJZt5vmWI1II=;
        b=U8h/hi65rEYl9ZwrUdAQHO6XEOuhpXXlAad6Bze3x97c25e9Fd2aCa4POkrkYRmFtH
         weU3GrYDdK2kbJXLZGkruOkGAR6s2DgtSVlPqEEz/BGHtB2GNaDCQH7UmItPsn93a04h
         uGsZn30hTVHwO2N2lwr+k9j2X/9HGvgHJSEtLGjaTx50c9s07bg9THkPEJl9fRTouwZF
         5oZN4gZggWFHdO/G+Y9ZoqGbiFof/TIvTQoihcJ0rhSOdubmL1yos1PNFeej04jzqbql
         yxfNmyPh4Qem+CxBi5FAjvLN6XR014zBV1zQiHvlZoiGh6F/WjckPabHoSGG1h0c7mVM
         LRCg==
X-Gm-Message-State: AOJu0YyW4OACNY6hA8uzy+qXvBEjRyggKCjXAL+c7vFqmZOAK+5iUQPF
	YjK6SJN/SpIbQdX4n1nur3QtRFimbR1XuygfWtPNT49x8q9N5NV7/3dLKprRWFQ=
X-Google-Smtp-Source: AGHT+IEjyNeOAVs0KsI2HYaw+x5O0V6Jfis1CPom+dYxNRm4InBqXYsV6heWEbkW9MhsFYXQf3dovQ==
X-Received: by 2002:a2e:a7ca:0:b0:2cf:2efa:e14a with SMTP id x10-20020a2ea7ca000000b002cf2efae14amr464246ljp.6.1706193428725;
        Thu, 25 Jan 2024 06:37:08 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id y24-20020a2e3218000000b002ce098d3f0asm292644ljy.115.2024.01.25.06.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 06:37:08 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 25 Jan 2024 15:37:06 +0100
Subject: [PATCH 2/7] mmc: moxart-mmc: Map the virtual page for PIO
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-mmc-proper-kmap-v1-2-ba953c1ac3f9@linaro.org>
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

Suggested-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/linux-mmc/20240122073423.GA25859@lst.de/
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/moxart-mmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
index 5cfdd3a86e54..7ccfe872415a 100644
--- a/drivers/mmc/host/moxart-mmc.c
+++ b/drivers/mmc/host/moxart-mmc.c
@@ -310,7 +310,7 @@ static void moxart_transfer_pio(struct moxart_host *host)
 	if (host->data_len == data->bytes_xfered)
 		return;
 
-	sgp = sg_virt(host->cur_sg);
+	sgp = kmap_local_page(sg_page(host->cur_sg));
 	remain = host->data_remain;
 
 	if (data->flags & MMC_DATA_WRITE) {
@@ -346,6 +346,7 @@ static void moxart_transfer_pio(struct moxart_host *host)
 		}
 	}
 
+	kunmap_local(sgp);
 	data->bytes_xfered += host->data_remain - remain;
 	host->data_remain = remain;
 

-- 
2.34.1


