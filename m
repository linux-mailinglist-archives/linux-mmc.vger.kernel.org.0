Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A88F15AAD7
	for <lists+linux-mmc@lfdr.de>; Wed, 12 Feb 2020 15:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgBLOTK (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 12 Feb 2020 09:19:10 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:36896 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727732AbgBLOTJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Feb 2020 09:19:09 -0500
Received: by mail-vk1-f195.google.com with SMTP id b2so546949vkk.4
        for <linux-mmc@vger.kernel.org>; Wed, 12 Feb 2020 06:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pD6JaSnVy6d9Wy91VgId+c/gK8kj7up124ZB0fp7Q6E=;
        b=QvRUkaFL/Hs7XFUJzhsgtE5zwCV5N5BPhe3Pxju+IXBgbBXWKmqmjp8oeaB9Gue2Yd
         3fauymD0v8WP0GVpAfGdEmrtuiVb7FbPfn8q2/UB6qiyBV4K0UUhThVWXsPanLJl/aFf
         WP2WS20JlFl1pHmcKc/LdWrtbYs/584iyApqu97LKrhtddg/WXTbGCHdCgiDuVtPSJ3/
         wBwafqWDBdtEGBU+XtZ5eiXu/LNBz863D3yGEUTHb/asqyXMA5Kmgc99cSUM/ZKDNvSp
         ambQr+a+K/65lwVKEY5CDLtfs/18TH/tnZ3QfX0nl9+YRF8Be6pSsRAvrHTUTrWSPlVW
         O+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pD6JaSnVy6d9Wy91VgId+c/gK8kj7up124ZB0fp7Q6E=;
        b=rhAVh4Pqcu4+6f+Z9Vbpa1zPKzf89doM54lrfCvHqc40t/1DnnkmK6mbWogfoczQqY
         d7hlJVv14IIWPvxpTd7DVDb5lui46zXtoPUvB5S8W1kEtYL4fgWPLF8/vuh0CLVADV+d
         0M66J44pg7wPKR+n9yj+t7sjxkxlVVabadHEYh7Nc6Er2NBZvVSR3bBE5SJjwBKtb1DU
         s97xy5B15kYReflnPsmp1N24Mbf9Ve57S0W6g0u8u/s73VaiaEUaJjI9kR6l67YE3wHn
         grxUmw4MSdVfBgN2hdl4YmyT+GZcpBu+eIwu8iUsOnoA7DJZBVXFbVq80jKV7dJrPmWL
         gl9w==
X-Gm-Message-State: APjAAAW6fbP21IqvbEPXmpVOBQWulLAao1y5daHHBTxtkZ5x/NMs53AX
        b5DixLv1NS9vmUFczLrqZUrgCorIS53clO2w3GEz5w==
X-Google-Smtp-Source: APXvYqyQyWDQ34AxS96GSO5ILw/KuYstIuPMV9toJErWROK2fwMJDOihptTw25fbWz1OnPeOl08cDhVP1niNJlpimW8=
X-Received: by 2002:a1f:434b:: with SMTP id q72mr7552551vka.53.1581517147883;
 Wed, 12 Feb 2020 06:19:07 -0800 (PST)
MIME-Version: 1.0
References: <20200204085449.32585-1-ulf.hansson@linaro.org>
 <20200204085449.32585-2-ulf.hansson@linaro.org> <7d6dc452-6ede-94d5-6bd6-fe1d5f4d28da@st.com>
In-Reply-To: <7d6dc452-6ede-94d5-6bd6-fe1d5f4d28da@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 12 Feb 2020 15:18:30 +0100
Message-ID: <CAPDyKFoUe-9HAz1SaCXGUss=GT5JuOVZpZYLmbUFi6Ee34O92g@mail.gmail.com>
Subject: Re: [PATCH 01/12] mmc: core: Throttle polling rate for CMD6
To:     Ludovic BARRE <ludovic.barre@st.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 12 Feb 2020 at 14:51, Ludovic BARRE <ludovic.barre@st.com> wrote:
>
> hi Ulf
>
> Le 2/4/20 =C3=A0 9:54 AM, Ulf Hansson a =C3=A9crit :
> > In mmc_poll_for_busy() we loop continuously, either by sending a CMD13 =
or
> > by invoking the ->card_busy() host ops, as to detect when the card stop=
s
> > signaling busy. This behaviour is problematic as it may cause CPU hoggi=
ng,
> > especially when the busy signal time reaches beyond a few ms.
> >
> > Let's fix the issue by adding a throttling mechanism, that inserts a
> > usleep_range() in between the polling attempts. The sleep range starts =
at
> > 16-32us, but increases for each loop by a factor of 2, up until the ran=
ge
>
> Just to align comment and code: in the code the first usleep range start
> at 32-64us.

Yeah, good point, thanks. I was trying different values, but forgot to
update the commit message. :-)

Other than that, does the change look good to you?

[...]

Kind regards
Uffe
