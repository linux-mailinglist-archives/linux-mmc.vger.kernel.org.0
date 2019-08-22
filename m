Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6D79995B4
	for <lists+linux-mmc@lfdr.de>; Thu, 22 Aug 2019 16:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732071AbfHVN7y (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 22 Aug 2019 09:59:54 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:46628 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731957AbfHVN7y (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Aug 2019 09:59:54 -0400
Received: by mail-vs1-f68.google.com with SMTP id x20so3651050vsx.13
        for <linux-mmc@vger.kernel.org>; Thu, 22 Aug 2019 06:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=b3vHhQNGBxHcKVwH+uonhkw9FooBO26oM11zaYhfnoo=;
        b=QsGYZpPDRpyM3rPT9wFDTqOwG5FTAEHZsiq6FnOkwzyJprQSFov/uKXhifor19wrb0
         70OmC2j6eynSh+F6rgS/M8PBO0e4A+22CGZhj/VMQ9dWx9Tn2tPY9+ds0GNZlgjdvGYi
         eaCggr+XhyAMwmTEQrznlSnCY+ENR/ObdTySZE70u46PQCa/KQ5cGL+97dlaX+IkmL/+
         SN6ZN3i3vNgFrEewv4LCPLlEDntvnACPvMp/qzImISfyLXLEYDFIjMMEq5mblyvUBKLk
         3F8hZI25Wxs3uMOyZA7yfhpPjIjcyXy1KD8O1CXX69BuER5MkVm3bfjPP8bygcMaA5Wx
         TBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=b3vHhQNGBxHcKVwH+uonhkw9FooBO26oM11zaYhfnoo=;
        b=Nqg3FJMVrrDMMFRBHV+sxCJ2xFAv7yuWZpK0/HzEBAN9uOlZ9kCTMDmHNUQAzAVIpF
         S0QGp6IsPqaaNstixyqQTDlSZBbRuEhQtAWTfHhr70fzn7abm1tBVnUZG/JqEvjFh0P8
         NTyEB0u53xy/glqFZ6nX4IuWSkUoLH8Rid4DIkChcuVV7kYhp5Qlfqdkm2KMGsiHiCdz
         noyAmjLPUjl6CFzOV8dR40XAFUPdacjvVuw4++29Ek7sZbAVOL9XuJ9hQEjbzToVBL8Y
         M/5u/pWbJpXpLkroBrWiyJy5O4BvVgspj7qGVCpzE4kzKmPG+t74izIC02DgTK0lyEY4
         Y74g==
X-Gm-Message-State: APjAAAV3U7/uer23HD7qqMio2w5NbqjKOxkklPXJIvxIJujrJ6TGDeo4
        8LSP2C9nbNpV6YW0VFWlVH6gioXeCwBWFwccnc/9w0ja
X-Google-Smtp-Source: APXvYqz0w0UrOgJ7HOiIX9nldy4dfTTG+t7Z4mK7MtsrqxMB1FuRXLos4uP/h8tdwdxqevIKMa+c/3Tfs73X0b799y0=
X-Received: by 2002:a67:fe4e:: with SMTP id m14mr4747094vsr.34.1566482393571;
 Thu, 22 Aug 2019 06:59:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190820114229.11948-1-ja.kaisrlik@gmail.com> <CAPDyKFrJvHGCEyAtih6wZNqFj+68icVBtWhDTrNf1Fr9kQQCig@mail.gmail.com>
 <CAPnxhu77vwKEx-_vzvPs_o5HsrZcSZ5eha7JPqJPjmv0Gzpkuw@mail.gmail.com>
In-Reply-To: <CAPnxhu77vwKEx-_vzvPs_o5HsrZcSZ5eha7JPqJPjmv0Gzpkuw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 22 Aug 2019 15:59:17 +0200
Message-ID: <CAPDyKFqMcsht8Ag6aGfoNeuUX+_zR-b0hUhVDyNpV5s6mmGYVA@mail.gmail.com>
Subject: Re: [PATCH] Revert "mmc: core: do not retry CMD6 in __mmc_switch()"
To:     Jan Kaisrlik <ja.kaisrlik@gmail.com>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ some meson driver folkz

On Thu, 22 Aug 2019 at 10:27, Jan Kaisrlik <ja.kaisrlik@gmail.com> wrote:
>
> st 21. 8. 2019 v 17:12 odes=C3=ADlatel Ulf Hansson <ulf.hansson@linaro.or=
g> napsal:
> >
> > + Chaotian Jing
> >
> > On Tue, 20 Aug 2019 at 13:42, <ja.kaisrlik@gmail.com> wrote:
> > >
> > > From: Jan Kaisrlik <ja.kaisrlik@gmail.com>
> > >
> > > This reverts commit 3a0681c7448b174e5dcfd19e9079cdd281c35f1a.
> > >
> > > Turns out the patch breaks initialization of Toshiba THGBMNG5.
> > > [    1.648951] mmc0: mmc_select_hs200 failed, error -84
> > > [    1.648988] mmc0: error -84 whilst initialising MMC card
> >
> > For exactly this reason, when getting CRC errors on the first attempt,
> > doing a retry makes little sense.
> >
> > I have looped in Chaotian who has some more details about the problem.
> >
> > In any case, Jan, what HW and mmc controller are you using?
>
> It's a custom board based on Amlogic A113D. The compatibility in dts
> is set to "alogic,meson-axg-mmc".

Good. I have looped in some of the relevant developers/maintainers.

>
> In the different revision of HW we are using Kingston EMMC04G. The
> card has no such problem and is working fine without this patch.
> We observed it only on mention Toshiba card.

I see. Of course it would also be interesting to see what CMD6 command
that is that fails. Would you mind adding some debug/trace to find out
what command it is that fails?

[...]

Kind regards
Uffe
