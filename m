Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30FD61E079E
	for <lists+linux-mmc@lfdr.de>; Mon, 25 May 2020 09:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388982AbgEYHPy (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 25 May 2020 03:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388972AbgEYHPx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 25 May 2020 03:15:53 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68795C061A0E
        for <linux-mmc@vger.kernel.org>; Mon, 25 May 2020 00:15:53 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id g14so98940uaq.0
        for <linux-mmc@vger.kernel.org>; Mon, 25 May 2020 00:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tW47sLPl7yvQUlpsqFGaRt0/eA0f/XtExRc8VNJ5L8s=;
        b=X3f906WAm1B7znVikPVukV6tgsYYUkm8v+SSd0x+rtjZfgsQwXU/C5hodPsbUpzf+R
         BsNenIyHnRQKNVI0gEyOsBlWkBG9l8kpemHYf5arLdSXoKccfSR3MFVTK8U28fiH6RFy
         zpF/6oIiC1R937exP0cxNj+fLhwVY5mLbZLV4dAnb+aI8JqZcUh6rWxOf0f+av+GNbEO
         Qno7YKLbvApPD9bO42MZre7gFikypcUpyT6VmJmffeKr84+gD7MR4Fb6R8cH1oPFWWTr
         ICbH30dzo42Yu5VE2FUsF3x6DtchJd7jbvjnBmUjmQDi3KtvBDtnQfJBA4d0R3eKGEM7
         ad7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tW47sLPl7yvQUlpsqFGaRt0/eA0f/XtExRc8VNJ5L8s=;
        b=aOOxaq3YsuSpXAbQ6W6oQFxPTkwZ78HgywtgJaBcoxB1E4TBOKseCv+dMvAEfyV5vh
         TlDWHjWi5Ix1PUiZ192vcVPGvUc8uMgQ7jA2kLvPwqc4PiSsJOuy/yYIO02Oj3LHnKgP
         TOCS0O75HIvjBcD/lyF0ZEbpcAhMZv9CWfqT3a9jD+TE3qfylPRog4bimkkozwTwKoG0
         ah32qGidavtm9fpFa/5TZRwLLXeT54dbdO7z55tT0UE4SGgyijQuYB+feSn/FDvDvOJH
         esoDJJMewW4vh7dxf9E0X+kt9EKpN2eMJnHJ990WdwQdZwex7fJ9ng8szKd8KVZcWF8H
         LrWg==
X-Gm-Message-State: AOAM533KFIvahXtj0rn12LQMOYFWZHTofszi1xc8cfezl/W1yXboF6bE
        6mcRtLU0ZVaxIyj6oksq3WHIhXoNZLsdK/ReFqgNdw==
X-Google-Smtp-Source: ABdhPJyn+vBET+wry7tIEPuyPG84ngjDJAb2r8EvcfU02yuysMA8153T8p81LOO/yO3mggJ+Oo/TpwlvMW9/07YJ+KQ=
X-Received: by 2002:ab0:7293:: with SMTP id w19mr17816123uao.129.1590390952511;
 Mon, 25 May 2020 00:15:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200522144412.19712-1-pali@kernel.org>
In-Reply-To: <20200522144412.19712-1-pali@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 25 May 2020 09:15:16 +0200
Message-ID: <CAPDyKFqwrtJy2Ss0_KcBtpGP78d_BePTGJp01KtfuOaQqiwiHg@mail.gmail.com>
Subject: Re: [PATCH 00/11] mmc: sdio: Move SDIO IDs from drivers to common
 include file
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ath10k@lists.infradead.org, b43-dev@lists.infradead.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list <brcm80211-dev-list@cypress.com>,
        libertas-dev@lists.infradead.org,
        linux-wireless <linux-wireless@vger.kernel.org>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 22 May 2020 at 16:45, Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> Most SDIO IDs are defined in the common include file linux/mmc/sdio_ids.h=
.
> But some drivers define IDs locally or do not use existing macros from th=
e
> common include file.
>
> This patch series fixes above inconsistency. It defines missing macro nam=
es
> and moves all remaining SDIO IDs from drivers to the common include file.
> Also some macro names are changed to follow existing naming conventions.

Thanks - a nice cleanup!

I guess this is best queued via my mmc tree, unless bluetooth/wireless
maintainers think there are some problems with that. I will wait for
an ack from them before applying.

Kind regards
Uffe

>
> Pali Roh=C3=A1r (11):
>   mmc: sdio: Fix macro name for Marvell device with ID 0x9134
>   mmc: sdio: Change macro names for Marvell 8688 modules
>   mmc: sdio: Move SDIO IDs from mwifiex driver to common include file
>   mmc: sdio: Move SDIO IDs from btmrvl driver to common include file
>   mmc: sdio: Move SDIO IDs from btmtksdio driver to common include file
>   mmc: sdio: Move SDIO IDs from smssdio driver to common include file
>   mmc: sdio: Move SDIO IDs from ath6kl driver to common include file
>   mmc: sdio: Move SDIO IDs from ath10k driver to common include file
>   mmc: sdio: Move SDIO IDs from b43-sdio driver to common include file
>   mmc: sdio: Fix Cypress SDIO IDs macros in common include file
>   mmc: sdio: Sort all SDIO IDs in common include file
>
>  drivers/bluetooth/btmrvl_sdio.c               | 18 ++--
>  drivers/bluetooth/btmtksdio.c                 |  4 +-
>  drivers/media/mmc/siano/smssdio.c             | 10 +-
>  drivers/mmc/core/quirks.h                     |  2 +-
>  drivers/net/wireless/ath/ath10k/sdio.c        | 25 ++---
>  drivers/net/wireless/ath/ath10k/sdio.h        |  8 --
>  drivers/net/wireless/ath/ath6kl/hif.h         |  6 --
>  drivers/net/wireless/ath/ath6kl/sdio.c        | 17 ++--
>  drivers/net/wireless/broadcom/b43/sdio.c      |  4 +-
>  .../broadcom/brcm80211/brcmfmac/bcmsdh.c      |  6 +-
>  .../broadcom/brcm80211/brcmfmac/sdio.c        |  4 +-
>  .../net/wireless/marvell/libertas/if_sdio.c   |  2 +-
>  drivers/net/wireless/marvell/mwifiex/sdio.c   | 38 ++------
>  include/linux/mmc/sdio_ids.h                  | 94 ++++++++++++++-----
>  14 files changed, 120 insertions(+), 118 deletions(-)
>
> --
> 2.20.1
>
