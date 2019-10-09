Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1C91D0A9F
	for <lists+linux-mmc@lfdr.de>; Wed,  9 Oct 2019 11:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfJIJMw (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 9 Oct 2019 05:12:52 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:47089 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfJIJMw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Oct 2019 05:12:52 -0400
Received: by mail-vs1-f68.google.com with SMTP id z14so1000366vsz.13
        for <linux-mmc@vger.kernel.org>; Wed, 09 Oct 2019 02:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DnaMjWPHRTxP2HwHozaEda4iUBnS+Mgb8NeafSlvJXU=;
        b=yKNY9SGcN2UsFvhR61yYb/jrlCVKgel12IYbR40rpV44lcbYSBZBivKCyQa3goz2oi
         wVn3L9kPGJF9gxBuLeJ34zX2+mGkfp28ZbQrzgrGx653cBpNaahPfaGFn/7zIN1RLXzR
         N9d9Glovn5NceLF76IOJ8fuPAyYZHS4PO6Hp6PUO1I/Y5PtLaqHiOpDeqVejYagbTlau
         AOiiySye8tVrQ7tMtrxJ4JTu0nNgQRdmTllW/3qJsQa/aV2UQw8hG9CBM6b6JwfIbyaQ
         MqKF6DODn7ifaUKjsfyiAna4yN7hfctndvK63mGetiRedO0K8Ct7Ym3KXmbe/EroZtSU
         zejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DnaMjWPHRTxP2HwHozaEda4iUBnS+Mgb8NeafSlvJXU=;
        b=Mlct3tF+5k5N1ntkMrJMfmi7fErL3H/DHTJDhrctCElUZSobcVegydo4c7rS4IB99F
         EGAWr+1DRXa4c13zzzsoU3R19STaQz4FM1r90KyoH7sDuy5f6ddrGP58FCEvnHOdPZYk
         nwMsaUQm5t7aoaZKJilzH7ydd1kbvuMoJDVfnx7ARit4Y5EQFYEHbLnaQolZ4A5bDJqW
         rJ7SRB+PGvKPUgJKev6cfMZMDT9Ma51Ni8EcL6Q5XsNj+CfkuFH3AXi6Xk1CkyhPFydo
         1usR4jUATs9nFTpOOGt3i9qx3v2XXgNFMS5GSdKczvJOuyMs+2PSYZUNdCWkW+MTGDHB
         Zlfg==
X-Gm-Message-State: APjAAAW8AXpmI8d1+OjBovlxkQFU13BJV6dIW+4ceGRYr/Mr3qVQXWSB
        PpzV82Pn5bfur9+NYxgKtbZnELouZquv4g7p8P5s0Ly6
X-Google-Smtp-Source: APXvYqwgsztQiejuumwMxLuyf8Ws3mo/ua2qL5BsBkseZLgZ/7p7G5FLcbikY8xut9BZ+djUlLpEqm30PBOLplnZkwU=
X-Received: by 2002:a05:6102:5e1:: with SMTP id w1mr1211701vsf.191.1570612371638;
 Wed, 09 Oct 2019 02:12:51 -0700 (PDT)
MIME-Version: 1.0
References: <20191008095604.20675-1-ludovic.Barre@st.com>
In-Reply-To: <20191008095604.20675-1-ludovic.Barre@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 9 Oct 2019 11:12:14 +0200
Message-ID: <CAPDyKFrKrV3e6WmrgzUA0OV4VGm0BMXr0=orogAhHQM3nRpxqQ@mail.gmail.com>
Subject: Re: [PATCH V7 0/3] mmc: mmci: add busy detect for stm32 sdmmc variant
To:     Ludovic Barre <ludovic.Barre@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 8 Oct 2019 at 11:56, Ludovic Barre <ludovic.Barre@st.com> wrote:
>
> From: Ludovic Barre <ludovic.barre@st.com>
>
> This patch series adds busy detect for stm32 sdmmc variant.
> Some adaptations are required:
> -On sdmmc the data timer is started on data transfert
> and busy state, so we must add hardware busy timeout support.
> -Add busy_complete callback at mmci_host_ops to allow to define
> a specific busy completion by variant.
> -Add sdmmc busy_complete callback.
>
> V7:
> -Patch 1/3: rephrasing like proposed (thx ulf)
> -If busy timeout is undefined => increase to 10s
> -Keep busy_detect.
> -Patch 3/3: rephrasing comment header
> -Avoid twice read of status register
> -Avoid writing in MMCIMASK0 & MMCICLEAR if not modified
>

Applied for next, thanks!

[...]

Kind regards
Uffe
