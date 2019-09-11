Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2972EAFC6B
	for <lists+linux-mmc@lfdr.de>; Wed, 11 Sep 2019 14:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfIKMVu (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 11 Sep 2019 08:21:50 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:36720 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbfIKMVu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Sep 2019 08:21:50 -0400
Received: by mail-vk1-f196.google.com with SMTP id b25so4294250vkk.3
        for <linux-mmc@vger.kernel.org>; Wed, 11 Sep 2019 05:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gTFIgpr+BcZ9Ar7qugX+r0CFY7uwPpyLv534R5un/gE=;
        b=aaG4ZdPC/9Ptcct0sLJUnguVL1nNblGzY8EBBRcMdIaUfXuixKimTwh7HfoUAWOeYT
         UzqM+krVimv3wqrWutjvqrizooRctBQu50nN47SdBX1EcQPlmjrc+tgniIygANzDKBpz
         SjKY2h9A9AFf9GjHo99ujNdF8Kqzi8hSZoKR6mOHIGeen8Lg19bA2pBkwuL5Ch88y019
         vwduy5KrYAMI+tn1Uj05hiYZ08RgRlMs+aX8Il4io48FgftiNHDl0XzA3qjqyx+dMfDk
         ts0JF45VYWt9Qpp7A0o8idosXC3OBtOFdSQwVljGId94PRUXgrCh11d7aVF9xv6ZliNx
         QqvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gTFIgpr+BcZ9Ar7qugX+r0CFY7uwPpyLv534R5un/gE=;
        b=oVivwM3ziq01o8gEYJ+GeQ27yxTeIkPIHdH/HlcviDcHK0Xc0hE8bfRLiU+9s6aQDy
         +MQvFFFy2Ky18mjzARAIuvTCYHqP4uhlz0A4c1N0xvgTkCS6v8R8pxhaW/v3CmpUDvPK
         c7zM31faQSeuR6O3JVRE/wZBOgHIdKbhNik12WbkdfDIQmr20JFAQBMi0QxCTzcqGXY7
         unUbDq/2FtG2imv/8x1S05u3QYlplR2gMYzIT4IQmlXZ3lB1QXhM9qPE/jHqSZ5xruUY
         mg++UgEEI6SDjzxSrZEYtvShE5T1AkFDRWf8d8RC0AgTWczYAGKywidE4dOwdiowHiKW
         HiTQ==
X-Gm-Message-State: APjAAAUUceB0LzDWiqB30OhuV4EUJx0kV3cx8X7MV1+GA9wGGcPW5DYR
        do54MXDYDrjolHcJHiyHgsNYDfjDR3CbpdfKi66OVQ==
X-Google-Smtp-Source: APXvYqw+xtgeAak4FCDho0kaEyRE4HavOitH5HuwTTZrxSjyEPx/N3Jc1TjMJO6nmL4NPZHtYGyQR1+4eEGInxt73LI=
X-Received: by 2002:a1f:8c50:: with SMTP id o77mr4202659vkd.52.1568204509548;
 Wed, 11 Sep 2019 05:21:49 -0700 (PDT)
MIME-Version: 1.0
References: <1568088179-16865-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1568088179-16865-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 11 Sep 2019 14:21:13 +0200
Message-ID: <CAPDyKFo0kQvBUys6cFwwZ5xF4koWh3DsFAN2x+NKXfz6O4AD3w@mail.gmail.com>
Subject: Re: [PATCH 0/2] mmc: queue: Fix bigger segments usage
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Thierry Reding <treding@nvidia.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ Christoph

On Tue, 10 Sep 2019 at 06:03, Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
>
> This patch series is based on the linux-next / next-20190904 tag.
> Thierry reported an issue which caused the SDHCI environment [1]
> so that I made this patch series to resolve the issue.
>
> [1]
> https://patchwork.kernel.org/patch/11137903/
>
> Also, this patch adds the flag to enable the feature on my
> environment.
>
> Yoshihiro Shimoda (2):
>   mmc: queue: Fix bigger segments usage
>   mmc: renesas_sdhi_internal_dmac: Add MMC_CAP2_MERGE_CAPABLE
>
>  drivers/mmc/core/queue.c                      | 8 +++++++-
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c | 2 +-
>  include/linux/mmc/host.h                      | 1 +
>  3 files changed, 9 insertions(+), 2 deletions(-)
>
> --
> 2.7.4
>

I can't apply this to my tree, as it depends on the earlier series
which has been queued by Christoph.

That said, you can add my ack for both of the patches and you probably
also need to repost this to Christoph.

Kind regards
Uffe
