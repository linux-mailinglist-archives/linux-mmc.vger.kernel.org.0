Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC452774688
	for <lists+linux-mmc@lfdr.de>; Tue,  8 Aug 2023 20:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbjHHS6A (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 8 Aug 2023 14:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235254AbjHHS5Q (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Aug 2023 14:57:16 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933BA1D47E
        for <linux-mmc@vger.kernel.org>; Tue,  8 Aug 2023 10:17:29 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3a6f3ef3155so4616262b6e.1
        for <linux-mmc@vger.kernel.org>; Tue, 08 Aug 2023 10:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691515049; x=1692119849;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Klg6b7rTmA3/2CEHhPBL9kFFomypTM/SqIrAORONAmA=;
        b=MgJgAqmpt+XBKNpAZMIlpp84quUFrRUmF7pvs27m7vdJy8UjwYEpAinrC8TLHVhhyC
         jUmkJ63yUP7UcMwSSAiXeeydAGHkd/DrduZkr4l4sQpw+uxDCb1B5xtjLuGuuye4vcxU
         mKpSPMxOOwtGX+rVpCBljnlP2AL903GgdBNZ7Lgm9nGBkH0zhGf6gkbcuJVuDJSSuuwf
         2DVkvtkJrmyX/63EQd80n9gMxtRZw0g+bCTn0W/pScNppaxI0W282fta9BthsDnHPCKy
         DwY9P7ZOsnIzZ53uRj36L2nfn+0cqDi79fGAH+JQ+KaC+Rq9tr+ZEOdFeI/4q1gVc/f9
         hsFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691515049; x=1692119849;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Klg6b7rTmA3/2CEHhPBL9kFFomypTM/SqIrAORONAmA=;
        b=GBjpwtCfKFjaNqRgvCGP37q0KrMESi6ZjABhyp1f2AWHkQWPu0RMpT3wvZ2jAIBUOL
         uPokm4G64IIuewFaui1zzcxKwfh+VXFvmypRKwZ4WzaFmch0A4fTDUVrQYmZscd4qqiF
         nhqKa1XQ6eBn5pM+RaYr4up2NTdoUYtZQfRxk8PiRjx42fc/gWvvo7N8yejlVOp+8PxK
         UXFBVuG0naX7xp4ACu/OuC/IIaJdeqtM8xvsYY/7bMVolVuB5vfQpgxF2JSL7Z8Nrx4e
         2wqA4mUKuEiTpS0PwRa9AjqIxJqUuScha1EZas6PM4yx0sFVO4IjmtkP0gihCpksPWhE
         gJLw==
X-Gm-Message-State: AOJu0Yzzvh8kkfqHPkAJIUJjvWpetZi6SkMTg8u0p8kss9jZDYcGqP+S
        PC/woiixjPQXXy0OFgrVvTDSHH8m108A9aN1ugHsmy6rNAC5hlqI4jI=
X-Google-Smtp-Source: AGHT+IFyFm7A28IM+G0on9OcPQxQMVC4tFTmtVJz+gYpID8XubCbPflmb8sfgiBS79hEh9WW2BWOpIws/LS1JffnNds=
X-Received: by 2002:a05:6358:419b:b0:134:ca8a:7486 with SMTP id
 w27-20020a056358419b00b00134ca8a7486mr11887238rwc.28.1691492428398; Tue, 08
 Aug 2023 04:00:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689802933.git.daniel@makrotopia.org> <1ce5f56df546cec25ef741f381286f1d7c33d000.1689802933.git.daniel@makrotopia.org>
 <CAPDyKFqhZtCHVmCNnm_Qm7X+=GtJY8uNJOWOgZXuTTVEw0msNA@mail.gmail.com> <ZNGULFxXpLT7zn35@makrotopia.org>
In-Reply-To: <ZNGULFxXpLT7zn35@makrotopia.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Aug 2023 12:59:52 +0200
Message-ID: <CAPDyKFrpWgA=e-FSoKfYhWSOq5m5_pHjxgzaGeOFHFhU_mcmNw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/6] mmc: block: set fwnode of disk devices
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Dave Chinner <dchinner@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Jan Kara <jack@suse.cz>, Damien Le Moal <dlemoal@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, Min Li <min15.li@samsung.com>,
        Christian Loehle <CLoehle@hyperstone.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Hannes Reinecke <hare@suse.de>,
        Jack Wang <jinpu.wang@ionos.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Yeqi Fu <asuk4.q@gmail.com>, Avri Altman <avri.altman@wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ye Bin <yebin10@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 8 Aug 2023 at 03:02, Daniel Golle <daniel@makrotopia.org> wrote:
>
> Hi Ulf,
>
> thank you for reviewing and suggesting ways to improve this series!
>
> On Mon, Aug 07, 2023 at 03:48:31PM +0200, Ulf Hansson wrote:
> > On Thu, 20 Jul 2023 at 00:02, Daniel Golle <daniel@makrotopia.org> wrote:
> > >
> > > Set fwnode of disk devices to 'block', 'boot0' and 'boot1' subnodes of
> > > the mmc-card. This is done in preparation for having the eMMC act as
> > > NVMEM provider.
> >
> > Sorry, but I don't quite understand what you are trying to do here.
> > Maybe you should re-order the patches in the series so it becomes
> > clear why this is needed?
> >
> > Moreover, I don't see any DT docs being updated as a part of the
> > series, which looks like it is needed too. That would also help to
> > understand what you are proposing, I think.
>
> I've prepared a tree on Github which now also includes commits adding
> dt-bindings for block devices and partitions, so they can be referenced
> as nvmem-cells provider.
>
> The dt-schema addition supposedly explaining this specific patch:
>
> https://github.com/dangowrt/linux/commit/b399a758f0e1c444ae9443dc80902a30de54af09
>
> The whole tree:
>
> https://github.com/dangowrt/linux/commits/for-nvmem-next

Thanks for sharing. However, allow people to review, I suggest you
post a new version with the updated DT bindings included.

The point is, we really need confirmation from the DT maintainers -
otherwise this is simply a no go.

>
> Most comments have been addressed, however, I still depend on using
> either a class_interface *or* adding calls to add/remove the NVMEM
> representation of a block device to block/genhd.c as well as
> block/partitions/core.c, simply because afaik there isn't any better
> way for in-kernel users of block devices to be notified about the
> creation or removal of a block device.

Okay, so that needs further discussions then. I will try to chim in.

[...]

Kind regards
Uffe
