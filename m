Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA1DF33D16F
	for <lists+linux-mmc@lfdr.de>; Tue, 16 Mar 2021 11:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbhCPKKE (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 16 Mar 2021 06:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236524AbhCPKJk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Mar 2021 06:09:40 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A452C06174A
        for <linux-mmc@vger.kernel.org>; Tue, 16 Mar 2021 03:09:40 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id a15so17888470vsi.7
        for <linux-mmc@vger.kernel.org>; Tue, 16 Mar 2021 03:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X9Na/+PVWk4g8/wD78e6RJzQ9OBaw9J1B/mNYyZp3D0=;
        b=KessVOImWJDDR1sgc7VENaWUmsRfSUncqyyzC21NX8l+xTUX53x0lVIUGvM3aqDGfT
         NCokaTk+RCrR6uhrdMrcIaVSm4UqhmJrIdbj5qmkeZY7SaRDK74VNTnnfahN9GKuXifn
         yePKCw16clu+nHLXhV/WyUiQL6MEoishaN+NnLI5Ynnl8Wa2FRwcy1is4fnatnBv8ZSh
         C40VldW90jVLNGADVWZ1qaveWRKVR18oiFW7/99L74WaXIymMyYtzFkNNcmI5hUv+S62
         43bYue2/vusMDTZHn88QhEDzmL2l0N9lpWEqj7KrPxwxeZ4T5UHh1WvbS2OY0XX4FpWW
         y0TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X9Na/+PVWk4g8/wD78e6RJzQ9OBaw9J1B/mNYyZp3D0=;
        b=fNxMrJUcuWcDG4GnpaJMok4L4Qr79ccjG49A/VR/DIMjRv+Wv7BPzSYceEeRLV8MF1
         ZD0VmBxfVOaxl5aAs5NTE7PgJFAFf+eqzCRsjOi84RBqECy+EQclAfQ09FnvspXlvFxS
         nvTF2r5RAKyU9AhHB70pLT9E+0NWQRMyt3nw8hQlOvvFmf+rGgUZNZNRS3NPqD8ZKPRE
         s1nc/x0x4wgaIlHEiTEOzWy/ko5f1IuRi3oLyonVrJu5OHjYOoXsSpKHC7DpuILgStmO
         SkL43boPgmgcmkhVcBBbLpN17cX7BiixpJGbFPDQ2ICjPrNV1FYaHfw99Q2mo1NyTuYF
         ZJoA==
X-Gm-Message-State: AOAM532E95d51ZGmtZZRWXFPf1IACLPFIVtiv1RuUeIsdegadCiONuOc
        Z5Asyb8/pqcN2ejqzwXB0VAWkvTaitKJxIM6IZ3G+w==
X-Google-Smtp-Source: ABdhPJx6ejJioJvxX9xBl7ZLIjG5O3H107YOWCKPYNw5Wez9IAWnZN+og/+StGRsHqI5UT4RW1mvFgG96vGwADmv/34=
X-Received: by 2002:a67:77c1:: with SMTP id s184mr6734329vsc.55.1615889378445;
 Tue, 16 Mar 2021 03:09:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210309015750.6283-1-peng.zhou@mediatek.com> <CACRpkdYTkW7b9SFEY6Ubq4NicgR_5ewQMjE2zHvGbgxYadhHQQ@mail.gmail.com>
 <YEpqkAq6wOZ+TpR9@gmail.com> <CAPDyKFoWg7HYHAbxYJRbOad5kqm+rzVLVQ0O3g76ROO5Z+MF3Q@mail.gmail.com>
 <1615884533.21508.118.camel@mbjsdccf07>
In-Reply-To: <1615884533.21508.118.camel@mbjsdccf07>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 16 Mar 2021 11:09:01 +0100
Message-ID: <CAPDyKFqtjYVAAe_wUKQC3n3ok5bUpGtpu=TUiOgFmbb6+Qkg=A@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] mmc: Mediatek: enable crypto hardware engine
To:     "Peng.Zhou" <peng.zhou@mediatek.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-block <linux-block@vger.kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Satya Tangirala <satyat@google.com>,
        Wulin Li <wulin.li@mediatek.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 16 Mar 2021 at 09:55, Peng.Zhou <peng.zhou@mediatek.com> wrote:
>
> On Fri, 2021-03-12 at 10:05 +0100, Ulf Hansson wrote:
> > + Arnd, Sudeep
> >
> > On Thu, 11 Mar 2021 at 20:08, Eric Biggers <ebiggers@kernel.org> wrote:
> > >
> > > On Thu, Mar 11, 2021 at 02:48:23PM +0100, Linus Walleij wrote:
> > > > Hi Peng,
> > > >
> > > > thanks for your patch!
> > > >
> > > > On Tue, Mar 9, 2021 at 3:06 AM Peng Zhou <peng.zhou@mediatek.com> wrote:
> > > >
> > > > > Use SMC call enable hardware crypto engine
> > > > > due to it only be changed in ATF(EL3).
> > > > >
> > > > > Signed-off-by: Peng Zhou <peng.zhou@mediatek.com>
> > > >
> > > > Unfortunately this commit message is way to short to
> > > > understand what is going on, and has a lot of assumed
> > > > previous knowledge.
> > > >
> > > > Can you expand the commit message so that anyone
> > > > who just know MMC and some SoC basics can understand
> > > > what an SMC call and and what ATF(EL3) means?
> > > >
> > > > I assume this some kind of inline encryption?
> > > >
> > > > I think maybe linux-block mailing list need to be involved
> > > > because there is certain a Linux standard way of setting
> > > > up inline encryption for the block layer.
> > > >
> > > > For example: how is the key to be used derived?
> > > > How is the device unlocked in the first place?
> > > >
> > > > If I insert a LUKS encrypted harddrive in a Linux machine
> > > > the whole system is pretty much aware of how this should
> > > > be handled and everything "just works", I enter a pass
> > > > phrase and off it goes. I can use symmetric keys as well.
> > > > How is this stuff done for this hardware?
> > > >
> > > > > +       /*
> > > > > +        * 1: MSDC_AES_CTL_INIT
> > > > > +        * 4: cap_id, no-meaning now
> > > > > +        * 1: cfg_id, we choose the second cfg group
> > > > > +        */
> > > > > +       if (mmc->caps2 & MMC_CAP2_CRYPTO)
> > > > > +               arm_smccc_smc(MTK_SIP_MMC_CONTROL,
> > > > > +                             1, 4, 1, 0, 0, 0, 0, &smccc_res);
> > > >
> > > > The same as above: these comments assume that everyone
> > > > already knows what is going on.
> > > >
> > > > AES encryption requires a key and I don't see the driver
> > > > setting up any key. How is the code in this file:
> > > > drivers/mmc/core/crypto.c
> > > > interacting with your driver?
> > > > drivers/mmc/host/cqhci-crypto.c
> > > > is used by SDHCI and is quite readable and I see what is going on.
> > > > For example it contains functions like:
> > > > cqhci_crypto_program_key()
> > > > cqhci_crypto_keyslot_program()
> > > > cqhci_crypto_clear_keyslot()
> > > > cqhci_crypto_keyslot_evict()
> > > > cqhci_find_blk_crypto_mode()
> > > >
> > > > MMC_CAP2_CRYPTO is used as a sign that the driver
> > > > can do inline encryption, then devm_blk_ksm_init() is called
> > > > to initialize a block encryption abstraction with the block layer.
> > > > Ops are registered using
> > > > struct blk_ksm_ll_ops cqhci_ksm_ops.
> > > >
> > > > This is very straight forward.
> > > >
> > > > But where does all the above happen for this driver?
> > > >
> > >
> > > It happens in the same place, cqhci-crypto.c.  Mediatek's eMMC inline encryption
> > > hardware follows the eMMC standard fairly closely, so Peng's patch series just
> > > sets MMC_CAP2_CRYPTO to make it use the standard cqhci crypto code, and does a
> > > couple extra things to actually enable the hardware's crypto support on Mediatek
> > > platforms since it isn't enabled by default.  (*Why* it requires an SMC call to
> > > enable instead of just working as expected, I don't know though.)
> >
> > As I have probably indicated earlier, I am starting to become more and
> > more annoyed with these arm_smccc_smc() calls in generic drivers.
> >
> > As a matter of fact, I think the situation is about to explode. Just
> > do a "git grep arm_smccc_smc" and you will find that it's not only SoC
> > specific drivers that call them. In general we want to keep drivers
> > portable and this is clearly moving in the wrong direction. Or maybe
> > it's just me being grumpy and having a bad day. :-)
> >
> > In the Qcom mmc case (drivers/mmc/host/sdhci-msm.c) for eMMC inline
> > encryption, the arm_smccc_smc() call is slightly better handled as
> > it's abstracted behind a Qcom specific firmware API. So, sdhci-msm.c
> > calls qcom_scm_ice_set_key() (implemented in
> > drivers/firmware/qcom_scm.c) to program a key. I guess we don't have
> > an abstraction layer that would fit for this case, right?
> >
> > My point is, when there is no proper abstraction layer to use for the
> > relevant arm_smccc_smc() call, the Qcom way is fine to me.
> >
> > In this Mediatek case, it looks slightly different. To me it looks
> > more like a resource that needs to be turned on/off to enable/disable
> > the "inline encryption engine". Could it be modeled as phy,
> > power-rail, clock, pinctrl or perhaps behind a PM domain (where SoC
> > specific calls makes perfect sense).
> >
> > Peng can you please elaborate on what goes on behind the
> > arm_smccc_smc() call, as that would help us to understand what
> > abstraction layer to pick?
> >
> > [...]
> >
> > Kind regards
> > Uffe
>
> Hi All,
>
> First of all, I appreciated that you are interested in my patch series
> and give me so much significant suggestions! Then, please let me summary
> the detail information about MediaTek eMMC hardware crypto IP.
>
> Before that, as you know, due to I work for MediaTek.inc that means I'm
> as an employee in this mail thread, so I don't give any comment about
> other SoC manufacturers.I will only focus on ours.
>
>
> [Background] Why I upstream this patch series?
> Obiviously, we want to support hardware level file base encryption, file
> encryption had been a mandatory feature in mobile device such as Android
> environment.
>
> A few years ago, we only support software level file encryption, it
> based on the reality of that time:
>  - There is no official encryption specification announced by JEDEC or
> any device manufacturers
>  - File based encryption is not a mandatory feature for mobile devices
>  - Security is not the highest priority thing for our most of Customers
>
> Time can fly and Market requirement is also, hardware level encryption
> functions had been add in our SoCs in soon, because that:
>  - An encryption specification which is widely recognized by device
> manufacturers and SoC manufacturers had been announced. Although it
> doesn't been accepted by JEDEC until now, most of eMMC device
> manufacturers had support it.
>  - Performance, special in low end mobile device, to some extent,
> hardware encryption could reduce some CPU loading,
>  - Almost overnight, Security has became the super star, everyone want
> it, consider the performance (comparing with full disk encryption) and
> flexibility, file based encryption is indispensable.
>
> One more thing, there is no common framework in kernel when our SoCs had
> crypto IP in that time, so we design a special framework in kernel to
> support it. In fact, we had support hardware encryption for several
> years in a special and non-public way.
>
> You'll know the rest, Eric design a common framework that lets SoC
> manufacturers support hardware encryption easier now. That' why we give
> up our own special private way and try to support it.
>
> In fact, at this point in time, we have used this framework(include my
> patch series) in our mobile products with newest Android version for
> almost one year.
>
>
> [Your question] Why we need use SMC call in our driver? or Why our
> crypto hardware IP is not default on?
>
> Yes, MediaTek eMMC crypto hardware IP is default off in current design
> and most important is we only turn it on in ARM exception level 3
> (EL3,the highest security level), that means we can only control it
> under ARM trust firmware (ATF) environment, but kernel space (it's EL2
> in our platform).
>
> I can get your bewilderment: why it's default off and why put it in high
> security level control?

Actually, I don't have an issue with this, at all. Instead, my worries
are about keeping generic drivers portable, which means resources need
to be modelled through proper abstraction layers. SoC specific drivers
are different, they don't necessarily need to cope with this
requirement.

Additionally, to me, it makes perfect sense to allow the crypto IP
block to be powered off, as you would likely waste energy to have it
always powered on, especially when it's not being in use.

So, this boils down to understand what "turn on" crypto hardware IP
actually means? Is it a clock, a phy, a power-rail or perhaps a
combination of things that is turned on for the IP to work? What
happens behind the SMC call?

The answer to this question will help us understand what abstraction
layer we should pick.

[...]

>
> [Your suggestion]
> In general, I agree it, and I will check qcom's solution then try to do
> a firmware layer for our eMMC driver to call.

According to what you have described, I don't think the Qcom solution
is feasible for this case. In your case it's about turning on a
resource and not about programming a key.

I am sure we can find an existing abstraction layer to use, we just
need to agree on which one that makes best sense.

Kind regards
Uffe
