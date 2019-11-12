Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9D7F9DDC
	for <lists+linux-mmc@lfdr.de>; Wed, 13 Nov 2019 00:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfKLXL1 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 12 Nov 2019 18:11:27 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:32904 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbfKLXL0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Nov 2019 18:11:26 -0500
Received: by mail-lj1-f194.google.com with SMTP id t5so368202ljk.0
        for <linux-mmc@vger.kernel.org>; Tue, 12 Nov 2019 15:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tvqr7Enmi/ocfgyYnlGqiPzgim6aB1Y8HMuhsyaz+1w=;
        b=B2Tn4fYYTM5wjuJbkUXQ/aZsUJCZagjIoofBHyG9XGuS6huwxn+NT/c21aOLx3Ns1A
         fbf8EXVwP1/r8dh7qggQQEsV8nmGPxeNeP2Ln7RxFSCV+foMB7IlY9pnMabajCGj+LYD
         rM8BOrOC4rcPFI+scgGEMMpRzf4b1Y+MOz4CZMl8LCs7Oru7L9CD5eYBDoc9xZheHpdT
         6gkXvVSv0JFwwthrGvV+e56ZMTendxbU4fxtH6Y+3i6+ECSzrSItfRNURo8JYNSUPrTU
         Uo1dUwtjIh1BeMGbBbdk+k95ztODpSUKnU/sGOaHywltcGXpq5FmKqi7jsj3+Tm/HePc
         Xllg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tvqr7Enmi/ocfgyYnlGqiPzgim6aB1Y8HMuhsyaz+1w=;
        b=E9SFbslBeG/Eob2Z1ct5LdV2MdhVcCA3iCyUmIprtYYvZHj8w0V2ZNqrGuArM1eKOL
         +64vaSDuxJXAFUDTnwrphSsRBfvQ4HnFBEzrvSF4e5u/zHnfwO5I1aTPinZHhXK3zIwI
         pv9pup7DFYlJP2UBxLLdhiZVvki1i/wcypBBTe+YOAFx1uP8Fgzbc6DE7mS5JFmAlE+r
         9Kb/F7iZ/5ItllRfNeKutwIZDkJzQhP7yeE3qkgocyqwRdX7aSHd6nDlzhN3nN42RpCt
         7J8PM5xXNxQDjMT8GM1GiTHAP3nRBgnnbf90yF+vx6SAjF007DTu/rtnnU0c3f40GWgW
         TFiA==
X-Gm-Message-State: APjAAAWSO91cTdDT5FnDV63SvhPo3fft+CkXoS52sIgsAu9H6B+LFB0u
        S+X3P+StCr3XL4w5EXfTQiHBn9y4xyeEdABkRb6vcA==
X-Google-Smtp-Source: APXvYqw7QDA1w5xtLQcUrrOL5Jz7y1c4OMfpHVZeNsT9aMfYuRsXUGzKt70JLZYhPoRVIzWv0w75TLlzz7akYxQc8hc=
X-Received: by 2002:a2e:90b:: with SMTP id 11mr152843ljj.233.1573600283271;
 Tue, 12 Nov 2019 15:11:23 -0800 (PST)
MIME-Version: 1.0
References: <20191105055015.23656-1-erosca@de.adit-jv.com> <20191105062223.GB1048@kunai>
 <20191105083213.GA24603@vmlxhi-102.adit-jv.com> <20191107003907.GA22634@bogus>
 <20191112211950.GB3402@kunai>
In-Reply-To: <20191112211950.GB3402@kunai>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 13 Nov 2019 00:11:11 +0100
Message-ID: <CACRpkdYyYAaW8AYqpC3E7eBx25-3yJqitSE=0yVfxCDtM-CwqA@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: mmc: Add 'fixed-emmc-driver-type-hs{200,400}'
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Rob Herring <robh@kernel.org>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Mathieu Malaterre <malat@debian.org>,
        Pavel Machek <pavel@ucw.cz>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Nov 12, 2019 at 10:19 PM Wolfram Sang <wsa@the-dreams.de> wrote:

> What I have seen so far: setting drive strength alone is more on the
> rare side. Setting specific values for default and HS200/400 seems even
> more rare to me. With this patchset, it is the first time I hear about
> it.

Like I wrote to Eugeniu this sounds like some kind of errata
for the eMMC ext CSD and should likely be a card quirk rather
than some generic device tree properties.

I might be wrong, we'll hash it out.

Yours,
Linus Walleij
