Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB98A1BC2B
	for <lists+linux-mmc@lfdr.de>; Mon, 13 May 2019 19:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730538AbfEMRrs (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 13 May 2019 13:47:48 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37335 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727814AbfEMRrs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 13 May 2019 13:47:48 -0400
Received: by mail-pl1-f195.google.com with SMTP id p15so6829247pll.4
        for <linux-mmc@vger.kernel.org>; Mon, 13 May 2019 10:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=7ftcbU8JnQmvm8sGh32+gWVqyGisGkp05zvI/Os1BUA=;
        b=aG5v8TAA+1qIp67dGGOJ7ud6fKmC9NYGNER2ymFATsKxSw7VEJIAcZr2RhZ15fOE+B
         xM9aXfO+Ft7I1MfUm4KhUZu+IaQTsAEf0ZUgfzyXoJqmDOKfJe66+f8zw4AuubJ+or27
         ufNo6pYKwNT8Q2CQZo2VhJrv8HJ0BChKp1IwSD51GT5N3nyfqhziSRmyrdLi7fiCHqsO
         j3XOAMVG4Yp4wboAfnQSKvQq9UFhKNB3o2DaThW4zr3zp8xLy/YYiycKAQjGpm/IhWaZ
         ofn9Dn3m2QyeTutPItizv/1Me+LzhsVv7veUC9Qx4hrZZ1nCfKt/wt9RPLbvy6vlzNwK
         N55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=7ftcbU8JnQmvm8sGh32+gWVqyGisGkp05zvI/Os1BUA=;
        b=k7solQ7YI1szL38URJlfpwhqYd9evWmc2kZ629Kk39a2jo/Th8lz1QF2tA/mIrEEm/
         ejFKXJdd5NAqfHLr/F/Tq28ChjWdFHw6fTpqVT2WFzZivjD0kBSTskZOtezR/QgNbv5u
         emTI/4w3dGCK++MJuegJGjuCR5Z2/SxveHFyiT82K9qMyX4pHBt9r/WwhfXbLbHPT/z+
         tsnAD/lLxb0FzNoSszlRBapJURZBdvgurACV7IFmC70AEI0AeqyRVqRJ82zOaW3qF2na
         2IGsWmXXbE00uLyMeyuseak2R6Gya3KAAd9TQI3Mb09qX9wBOGHDulsp42vKfa5n+5JS
         muVA==
X-Gm-Message-State: APjAAAWCMut3EKgUVwTVoOuWrj0PH8R5wTY+FqWGisix0AWSi9TrKn2v
        tb1z9mjO92384UfZaJVTFLC+IwEM+rMyAA==
X-Google-Smtp-Source: APXvYqykzOc6H2gQfaH2tmKL5VMylfiYXvxqcBKK0+ieVzRpKiH1CsSkvAVqvM2zkJDtRZ1QN5T4tw==
X-Received: by 2002:a17:902:e708:: with SMTP id co8mr32206427plb.141.1557769667349;
        Mon, 13 May 2019 10:47:47 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:fd66:a9bc:7c2c:636a])
        by smtp.googlemail.com with ESMTPSA id w12sm14856903pgp.51.2019.05.13.10.47.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 10:47:46 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, ulf.hansson@linaro.org
Cc:     baylibre-upstreaming@groups.io,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mmc: meson-gx: add ddr-access-quirk
In-Reply-To: <20190513091548.16674-3-narmstrong@baylibre.com>
References: <20190513091548.16674-1-narmstrong@baylibre.com> <20190513091548.16674-3-narmstrong@baylibre.com>
Date:   Mon, 13 May 2019 10:47:45 -0700
Message-ID: <7hd0kmckla.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> On the Amlogic G12A SoC family, (only) the SDIO controller fails to access
> the data from DDR, leading to a broken controller.
>
> But each MMC controller has 1,5KiB of SRAM after the registers, that can
> be used as bounce buffer to avoid direct DDR access from the integrated
> DMAs (this SRAM may be used by the boot ROM when DDR is not yet initialized).
>
> The quirk is to disable the chained descriptor for this controller, and
> use this SRAM memory zone as buffer for the bounce buffer fallback mode.
>
> The performance hit hasn't been evaluated, but the fix has been tested
> using a WiFi AP6398S SDIO module, and the iperf3 Bandwidth measurement gave
> 55.2 Mbits/sec over a 63 Hours long test, with the SDIO ios set as High-Speed
> at 50MHz clock. It gave 170 Mbits/sec as SDR104 and 200MHz clock.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

