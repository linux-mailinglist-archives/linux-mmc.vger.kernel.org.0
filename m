Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEAA3A30D4
	for <lists+linux-mmc@lfdr.de>; Fri, 30 Aug 2019 09:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbfH3HUG (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 30 Aug 2019 03:20:06 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:35009 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727866AbfH3HUF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Aug 2019 03:20:05 -0400
Received: by mail-vs1-f66.google.com with SMTP id q16so4162028vsm.2
        for <linux-mmc@vger.kernel.org>; Fri, 30 Aug 2019 00:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=28VtnhZLetuKNWTwnsupiNM8l/3Xr9JApxUQqA/jSLQ=;
        b=WawhvhYmWzIQL6MU/6+vZtOgC1oMf0Kaal5NRPxQKYClM9so5IZS/jKDunt34jPjS3
         G8xrl55MLrTUJSMcyIUgIy3OilhvlBZdcbdawFLsKBgMBGRgW29XLgRuXdWeJIjv8TOO
         tixtann9Lx146aYxIRWtVyZ0d+aFv8ikMDbSBkJoVSewI2wa8JiJzSUCqVnPeFWEPpcY
         go6yRgR63Uz5xeqx5u3JbrvK9bA5s7M2OTxbIH9CDPmXLjf8LWayhBHpWcynIqKyIuG9
         3SJrM4sZhE64gHQnvNWhtRPTrSM32CLkiiq11yrpRpbyo8evW6fSF1UXIH4tcg3W1pAs
         Mftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=28VtnhZLetuKNWTwnsupiNM8l/3Xr9JApxUQqA/jSLQ=;
        b=GXlVU5VhFFsTu4lNN34n7UfpPvGJbG9SoeK1dKl3uIFu31CfLEESqxeP+eehcwqxIJ
         RhYJ6aVDKdVUV0NCcY068chC6AyxuLOW8psGvHKRaCw853o9V6ZxMv0ykwGEnA7RBraa
         btD+3pE5dTU4zvNQ9I6VXfqioV4xHj4usbp+qSa+8uaPO3jcsEJD/R7ICEwrLGJ2MpaD
         n3K7JUfxZvlFsm28LYJx8XpShrMEd8ldiWcNinuCDy4avXbtNvvzgLKe83Yi92CClSmc
         2qUJ3FLiHdxOTHXDwpd3O3DM8q1F24jwnPddLiubHWqnoj5GyeniFhP9fFSr4K+auF4X
         rGlg==
X-Gm-Message-State: APjAAAWlNWIkTnsOhec8BgqKReAXl8A7v4GGsa0jNsWKMDk28exbj5at
        Y0gtOLhTk9w769ECRN9hB46BPFBW40MH9QXG0a+xA6I5
X-Google-Smtp-Source: APXvYqwRTzthMZv/p070SaQmVBrSKgxVL7QAyqiFS5dHq8lHhCYDWu5OgH6w+x08TxmBtLfvep1k6vyNWkpTQvVA2kA=
X-Received: by 2002:a67:e287:: with SMTP id g7mr7791406vsf.200.1567149604830;
 Fri, 30 Aug 2019 00:20:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190827081043.15443-1-ulf.hansson@linaro.org> <201908291723.x7THNWMj097729@thunder2.prohost.de>
In-Reply-To: <201908291723.x7THNWMj097729@thunder2.prohost.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 30 Aug 2019 09:19:28 +0200
Message-ID: <CAPDyKFrRArZ-nMWZuf_zzYX4Bc6x925o43bVPzpOU1Tv22BREA@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Fix init of SD cards reporting an invalid VDD range
To:     Manuel Presnitz <mail@mpy.de>
Cc:     Linux MMC Development <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 29 Aug 2019 at 19:42, Manuel Presnitz <mail@mpy.de> wrote:
>
> Thanks for your efforts and the patch!
>
> I tested it on my "Fujitsu Celsius H760" notebook running kernel version 5.2.7 (Arch). It has a "Realtek Semiconductor Co., Ltd. RTS524A PCI Express Card Reader" using the "rtsx_pci" module.
>
> Without the patch my "SanDisk Extreme SD-XC UHS-I" card (128GB) had thrown the error "mmc0: error -110 whilst initialising SD card", but with the patch the very same card is recognized and is working flawlessly!

That's great news, thanks for testing and reporting back!

I all a tested-by tag from you, thanks!

Kind regards
Uffe
