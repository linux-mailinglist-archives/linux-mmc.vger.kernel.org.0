Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F04DCDC346
	for <lists+linux-mmc@lfdr.de>; Fri, 18 Oct 2019 12:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438846AbfJRK7B (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 18 Oct 2019 06:59:01 -0400
Received: from mail-vs1-f45.google.com ([209.85.217.45]:34749 "EHLO
        mail-vs1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442499AbfJRK7B (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Oct 2019 06:59:01 -0400
Received: by mail-vs1-f45.google.com with SMTP id d3so3753353vsr.1
        for <linux-mmc@vger.kernel.org>; Fri, 18 Oct 2019 03:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=896y+aPaNq4Ksdf2JUM3r2DgmK0C6nISCKALY7hHEOY=;
        b=QXiCPd8PURCSMraHqjwbOYXBENRsJ5ZsOW78qx+VuUsZrKPV2ZOhbUyJebQzeFZdal
         527Qb1tiDaJyYC40Md0vcwHGrjdXT7t6zosQjuVqnTGaR74brB83OrjUNwrlg7s3fU4C
         KyQwlq8rm0mHn9rV7mqRtIGZ6IIkqQW2VHMK8oZ1z5h8mtCsRL6gs6bj0gCvevNTUkI/
         PM2f/gOjRsi/kQZU/zhgtGV75BNsxmVi0JqvuRQ48oC6bIl5kSGOqYu27/SpqZL4r4iK
         bRPnVcl8v630q1TowhhQyzkkdiRhCDeWQWXalNBdqcKwa90QlM8Jv4VPKCY/QMMbaK6r
         BJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=896y+aPaNq4Ksdf2JUM3r2DgmK0C6nISCKALY7hHEOY=;
        b=PJMMRO/YXaM8CEw7t1xCkhGKzzdvyfg1FJmulRHFXobhjb+wcinxsxag2yf+cFE/HZ
         Kia2HWzPhYdJDW0HRkZScoMFZiQGxIutBvuQzw/hxdyzMvQwjTyGMnKXvCH5vciEe0rd
         dAnztE3GVkOxPkk1MiaoX/7QDjf6rO7SgL9SJuHPwrPIO4Y6nEK9V0n3Tb1atVo80JJz
         lGIsmkGYxarEwtFv+DihE3CJTWrVjut/Il1kMPFg9kccnioOvDWNSgdXlEKF4TIFnMV9
         uzOmfA11oMckwf3TtLkyRcDbLZRXSTXg1LFMW9fNDUE/fRMWhvZKRs/I4vaF50Z/YGIc
         R9GA==
X-Gm-Message-State: APjAAAXDY55MC4X5Yn/QzDUEy+xOSi6Rw7r+8a+l1+kVd+h/Rzgt3w2o
        NHDQLitOxZ8LxWkzVpF9pyAnJupMomX0fRuucyp6FlPp
X-Google-Smtp-Source: APXvYqzZMl7IuIGHOXTbiMdDjeEAB2so5Uo76fdYZjvq7Q7b8B58azfkk1fZUxEDI4uHpmTw73W32Yd0ja+PsSuo4yM=
X-Received: by 2002:a67:ef89:: with SMTP id r9mr5102579vsp.200.1571396339955;
 Fri, 18 Oct 2019 03:58:59 -0700 (PDT)
MIME-Version: 1.0
References: <20191009074140.3934-1-yangbo.lu@nxp.com>
In-Reply-To: <20191009074140.3934-1-yangbo.lu@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 18 Oct 2019 12:58:23 +0200
Message-ID: <CAPDyKFp-5CsSvm24jMsiD0OdT=jLTBN_szEht6XwaT7isDK3Pg@mail.gmail.com>
Subject: Re: [v3, 0/2] mmc: sdhci-of-esdhc: fix up erratum A-008171 workaround
To:     Yangbo Lu <yangbo.lu@nxp.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 9 Oct 2019 at 09:40, Yangbo Lu <yangbo.lu@nxp.com> wrote:
>
> This patch-set is to fix up erratum A-008171 workaround. It had been
> verified on LS1046A eSDHC + Phison 32G eMMC which could trigger the
> erratum.
> ---
> Changes for v2:
>         - Dropped sdhci start_tuning() hook patch.
>         - Implemented SW tuning starting in eSDHC writew().
> Changes for v3:
>         - Converted to use esdhc_flush_async_fifo() and usleep_range().
>         - Added ACK of Adrian.
>
> Yangbo Lu (2):
>   mmc: sdhci-of-esdhc: poll ESDHC_FLUSH_ASYNC_FIFO bit until completion
>   mmc: sdhci-of-esdhc: fix up erratum A-008171 workaround
>
>  drivers/mmc/host/sdhci-esdhc.h    |  14 +++
>  drivers/mmc/host/sdhci-of-esdhc.c | 257 ++++++++++++++++++++++++++++++++------
>  2 files changed, 231 insertions(+), 40 deletions(-)
>
> --
> 2.7.4
>

Applied for next, thanks!

Kind regards
Uffe
