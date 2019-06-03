Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0717733AD6
	for <lists+linux-mmc@lfdr.de>; Tue,  4 Jun 2019 00:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfFCWKy (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 3 Jun 2019 18:10:54 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36923 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfFCWKx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Jun 2019 18:10:53 -0400
Received: by mail-pf1-f194.google.com with SMTP id a23so11403026pff.4
        for <linux-mmc@vger.kernel.org>; Mon, 03 Jun 2019 15:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=Lqtk1JLPJRbV/Uor8A27eWDozVcUr19IPuyQSb2ZXss=;
        b=LOMmLUn3OWji8hcp69Cer8ETlOICLjhPAltnN4rp4K5f25q0RlT24pWNBHwJHhZbmV
         2AOmASgj1C5kiQPqxC5BPsx0ELPuyx2MPcfB89pVUNo90bBPw2TRyhbzh5SH2Scu6/j8
         m64nBG/w+Yhv5R/ZfbzdPZw0gQ0oUVHxnJXordTCw9ZhsQak0YrH89m5teRm4Ut/zuvh
         GgbweAG/DCgafajg9GpEaZgoG0ZouFPc22PwC77s1UnfGj1yN3pzGXJgXrWenNphhHR9
         KJ1JQnfDizgW24Rp47icxjhjBl6WVLrhUsPnikns/XcaLkcA7vJy2Q2/jZAQk1GQB/eo
         bz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Lqtk1JLPJRbV/Uor8A27eWDozVcUr19IPuyQSb2ZXss=;
        b=LKgmtOoZwGVfy2bp1w/1jXw3yMfza0eUoKTnQ51nb81Q06+f5RNss/V7U0BLJys9dO
         x9NKl754UVaT8Qy0ToYF39f8rAmiiFCIKmYY22nuSj4xBYsPHjO7rDjSgBtU0ms7Yu9f
         C/IUiFq7BDiIOfI4xPCrcQsYDuWJEDMFQ2ixPPX/39uRNLlseCBmRo9P/bSJpRaiiF7T
         R7w/YdHFf1NTFetJMvGZT/zcM/aeFx7BNYYYXokts5t4KbYwsqW5otSeEpGUJUtGdDbS
         7et2XCvyLWdHJgU46yX/ttV1oNT7cL1GPpAGvlyqkjeAJXaNNc/75zoOzSBUV3C9rfgl
         Wm7A==
X-Gm-Message-State: APjAAAUc/kpeRfHwpmmWqx/B2X5sw+3Q9uzffEGCOT10cMIL34PS4DVp
        WUyMlhMXodfHB+svByhMoJS4oA==
X-Google-Smtp-Source: APXvYqxTWg1pff0VpEjIEtZaLRKwlbARqN5oAhRdttUjDIsDawnE2zYntfrph7HTS32iO+Wx978D4A==
X-Received: by 2002:a17:90a:29a4:: with SMTP id h33mr27038831pjd.105.1559599852823;
        Mon, 03 Jun 2019 15:10:52 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id p20sm27244237pgk.7.2019.06.03.15.10.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 15:10:52 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, ulf.hansson@linaro.org
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-mmc@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: meson: g12a: add SDIO controller
In-Reply-To: <20190527124307.32075-4-narmstrong@baylibre.com>
References: <20190527124307.32075-1-narmstrong@baylibre.com> <20190527124307.32075-4-narmstrong@baylibre.com>
Date:   Mon, 03 Jun 2019 15:10:51 -0700
Message-ID: <7hwoi2ial0.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> From: Jerome Brunet <jbrunet@baylibre.com>
>
> The Amlogic G12A SDIO Controller has a bug preventing direct DDR access,
> add the port A (SDIO) pinctrl and controller nodes and mark this specific
> controller with the amlogic,dram-access-quirk property.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Queued for v5.3,

Thanks,

Kevin
