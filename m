Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F42DFC4C6
	for <lists+linux-mmc@lfdr.de>; Thu, 14 Nov 2019 11:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbfKNK5B (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 14 Nov 2019 05:57:01 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:39529 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfKNK5A (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Nov 2019 05:57:00 -0500
Received: by mail-vs1-f67.google.com with SMTP id x21so3557974vsp.6
        for <linux-mmc@vger.kernel.org>; Thu, 14 Nov 2019 02:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WeEnAyy7qQpCSp7RUf5vRqqgRBjs74WC3kZmLk7/Ets=;
        b=hoeZrow+SCevu622cFh3TszkhCUOxa3lUQgjfUCIWC4BX/gNASmzS9cGhMXa4zNzKo
         +PERA2StHl/qsusa2pLHZSgkZPwoiECiBZcmKTTXMhJvLVnFBrIDWJxyv3t/BeGkiO0+
         tvEsYEmPc2swbb5vv+8SZQ7EK/BazbhLRQiOdBduH6DOYm/JOKqt18MH4D6VPtraUvku
         YLxxdMMG2HzwW9+302wLEGbodoqDcZA709B/SebE9PM2kwaTMSqK2lLJGxB2lnf7Y9bV
         970SL3Q3RFGvV2mfFl3M3E6iqr5Wj75p2WkXF+xehF2JxAhKe3Ewn7DGz7XF0XUVNtVu
         zZuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WeEnAyy7qQpCSp7RUf5vRqqgRBjs74WC3kZmLk7/Ets=;
        b=e0x9VuSlhr1JD95ipkvh1W83X0JwyL4umSj4GT5pIxHZ8B9+WgRxCPh+aKkN/cfIB5
         CI356Bgjh/OAJAzihBbZBe2PzySNjqEbo+dxpwB8bhJyhGvspmg7WamuXqkT6Rd5nPXc
         FTV4uY6C/HKK1SxDH/sZeM+uiKo24lvwZCbZ+st5kG9WnmSCRMV3BlKa69+3T1QgC8HY
         +s4FFTb7OH9d19gI1Jgml+pqkSp+CnEKy9TPGUIGX9d8jsLUdm+o/ZaNaP//VLwcT9yB
         ALJvZaEaw0zh+T7cHels3WXwGBcRFGi1pK+Ez/ELSD5GIlflbNDwR7KesIOAlGgI772i
         mWIA==
X-Gm-Message-State: APjAAAWYe/ObJCsROOljIC7bnNwJqx+dgkJa4Hxl1wZe0pm5RF7VK2eX
        6TOANkf8iCzXrVbD/V+QK8d/Qm135eVdnrRUSIEzvQ==
X-Google-Smtp-Source: APXvYqzOQq0UWfeeYjSHzzZXhI40LLsR/zrXlGUA890HQ1DWvHEp6xuek4vuAejASyAVhkmYw01lMEF15EypZPUQORk=
X-Received: by 2002:a67:fc04:: with SMTP id o4mr4992340vsq.35.1573729019802;
 Thu, 14 Nov 2019 02:56:59 -0800 (PST)
MIME-Version: 1.0
References: <20191112134808.23546-1-erosca@de.adit-jv.com> <20191112204952.GA2976@kunai>
In-Reply-To: <20191112204952.GA2976@kunai>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 14 Nov 2019 11:56:23 +0100
Message-ID: <CAPDyKFq8oVk26ruNA_R8HDXhMGKhDeHnL0q82xi40g1aeo109A@mail.gmail.com>
Subject: Re: [PATCH] mmc: renesas_sdhi_internal_dmac: Add MMC_CAP_ERASE to
 Gen3 SoCs
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Simon Horman <horms+renesas@verge.net.au>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Harish Jenny K N <harish_kandiga@mentor.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 12 Nov 2019 at 21:49, Wolfram Sang <wsa@the-dreams.de> wrote:
>
> On Tue, Nov 12, 2019 at 02:48:08PM +0100, Eugeniu Rosca wrote:
> > From: Harish Jenny K N <harish_kandiga@mentor.com>
> >
> > Enable MMC_CAP_ERASE capability in the driver to allow
> > erase/discard/trim requests.
> >
> > Suggested-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
> > Signed-off-by: Harish Jenny K N <harish_kandiga@mentor.com>
> > [erosca: Forward-port and test on v5.4-rc7 using H3ULCB-KF:
> >          "blkdiscard /dev/mmcblk0" passes with this patch applied
> >          and complains otherwise:
> >        "BLKDISCARD ioctl failed: Operation not supported"]
> > Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
>
> Looks good to me. Just a generic question, probably more for Ulf:
>
> Why does this CAP_ERASE exist? As I understand, the driver only needs to
> set the flag and no further handling is required. Why would a driver not
> set this flag and not support erase/trim commands?

I am working on removing the cap, altogether. Step by step, this is
getting closer now.

The main problem has been about busy detect timeouts, as an erase
command may have a very long busy timeout. On the host side, they
typically need to respect the cmd->busy_timeout for the request, and
if it can't because of some HW limitation, it needs to set
mmc->max_busy_timeout.

Once that is fixed for all, we can drop CAP_ERASE.

Kind regards
Uffe
