Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF857147DB
	for <lists+linux-mmc@lfdr.de>; Mon,  6 May 2019 11:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbfEFJwJ (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 6 May 2019 05:52:09 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:35405 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfEFJwI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 May 2019 05:52:08 -0400
Received: by mail-vs1-f66.google.com with SMTP id s4so3569940vsl.2
        for <linux-mmc@vger.kernel.org>; Mon, 06 May 2019 02:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DmsBhkWlYc1uTNw6jjpjWWASyR4UniOiR+IT6QHntHo=;
        b=ALeaEk9CIsi5/SHzgOkGrfo3YVdBP/hnx+rPsqMosbUzT0agIR+DCcF41mPVsIH2m/
         nEmge4VayE35vHVB6PNtNuDQN9TRFVwRnRnuuSlW/BhtKVXvA/t6YtvumSt6wVfDxGOl
         cAAVFBlC4/zDsCReQgHVykBYp3NFUxpFGlMUWxIl7tZVSo+g5l0AfZwpksDtUapreSoT
         pUSQXqkSuV+/usHSUlKtOCsB2eOKJZfn6/0mzeRcyhTHgQdal6D0WSRKAmzxIf+FBdaJ
         yxw2gNdbFGmBz7NxMKMxH/Zw3GLVlX0u3IR7vssLk1nTTI1tJTtRL2VdNeWAXSx9HEwW
         oLLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DmsBhkWlYc1uTNw6jjpjWWASyR4UniOiR+IT6QHntHo=;
        b=KHBIPKxHY7GVWuATErvaTTbvRcv0rqOOzfK1zEidnHxw2RsdW9n0j20C5GPN1c+qoi
         vLm3z4adecwh/nhy0XvOiC2i8aQLkDjDo2JsBw1HdK5stGf3jR5Yi3LtUOec/HYT5XZt
         U28DpxcwnGrcOM3RA2x1lE65zY7n7w5vvUg2u60m+kKwtl8IWGcNmDF13EAdoTgjkFSK
         KDGqC7t3h9ojbrq/CWgF98W327Q/v4th6xnWPnkHzzyEndn1RJlYOMTwFL9YxhoAm+7b
         kmjIUsWqZrWpgo/23CJW3gyjzgwGs02vH2NMkRCzTYFVvgKaiswkDnsvBxnv048TEmUb
         6n2Q==
X-Gm-Message-State: APjAAAV/11szrDJQEAwzjbk9fI0tSeveqzRucIEnpvm8mtaEcc6W3OUb
        AujMGN6Vq04VBeQ4sbFkPJHOwcelnl5b1Uh3h7INqg==
X-Google-Smtp-Source: APXvYqxF66GwjuWRom41i00LWsDcol9d1DnTeSM0hRqjZ8HvNnzE/hNVgU2a1XSbP9yYHmTqxELfJd0bOHoSwsErZRI=
X-Received: by 2002:a67:b44d:: with SMTP id c13mr12757692vsm.165.1557136326923;
 Mon, 06 May 2019 02:52:06 -0700 (PDT)
MIME-Version: 1.0
References: <155696540998.8632.5242582397805128125.stgit@noble.brown>
In-Reply-To: <155696540998.8632.5242582397805128125.stgit@noble.brown>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 6 May 2019 11:51:30 +0200
Message-ID: <CAPDyKFp9aQNsqkUnznPUaDDZf8Oa95MRKmb35Y-PuMbSJPfZug@mail.gmail.com>
Subject: Re: [PATCH 0/4] mtk-sd enhancement to support MT7621 - V2
To:     NeilBrown <neil@brown.name>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        thirtythreeforty@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 4 May 2019 at 12:25, NeilBrown <neil@brown.name> wrote:
>
> The MT7621 MIPS-based SOC contains an sdhci unit that is
> much the same as the units supported by mtk-sd.c.
>
> These patches enhance the driver so that I can use it on my MT7621
> board (gnubee.org).
>
> This series have been revised based on feedback from Chaotian.

Applied for next, thanks!

Kind regards
Uffe


>
> Thanks,
> NeilBrown
>
> ---
>
> NeilBrown (4):
>       mmc: mtk-sd: don't hard-code interrupt trigger type
>       mmc: mtk-sd: add support for config found in mt7620 family SOCs.
>       mmc: mtk-sd: enable internal card-detect logic.
>       mmc: mtk-sd: select REGULATOR
>
>
>  Documentation/devicetree/bindings/mmc/mtk-sd.txt |    1
>  drivers/mmc/host/Kconfig                         |    1
>  drivers/mmc/host/mtk-sd.c                        |   78 +++++++++++++++++++++-
>  3 files changed, 75 insertions(+), 5 deletions(-)
>
> --
> Signature
>
