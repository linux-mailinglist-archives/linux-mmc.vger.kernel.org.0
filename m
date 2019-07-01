Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0239E982
	for <lists+linux-mmc@lfdr.de>; Mon, 29 Apr 2019 19:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbfD2RuZ (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 29 Apr 2019 13:50:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:54074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728748AbfD2RuZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 29 Apr 2019 13:50:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D5E32087B;
        Mon, 29 Apr 2019 17:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556560224;
        bh=yxChAYiU/YL3D5H4BnSnqXUynWtFGwWprVZ0YhYmTGk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Oywe6CyITKsV6cgAiskNlTfC8QbsQ0ol7Rb6n81m6wATNA5YKA4uMkouLC9c1ItHG
         9jySRzfKSKhvCZj2aqLPpMuVy+fJWHcPxD1wtIAGHlc3HmrwtZ96k3EZbpffBAJOsT
         o7Ctm3ss4HaqHhH7QUIrNaAz7PVlurJFUb98dRFc=
Date:   Mon, 29 Apr 2019 19:50:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>,
        davem@davemloft.net, alexander.deucher@amd.com,
        tsoni@codeaurora.org, psodagud@codeaurora.org,
        jshriram@codeaurora.org, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] driver core: platform: Fix the usage of platform device
 name(pdev->name)
Message-ID: <20190429175022.GB21757@kroah.com>
References: <1555978589-4998-1-git-send-email-vnkgutta@codeaurora.org>
 <CAJKOXPeCPWPdE1d3EYr4bD1hLMRDXohaz-7yrmk_R-V6ZD6rhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJKOXPeCPWPdE1d3EYr4bD1hLMRDXohaz-7yrmk_R-V6ZD6rhQ@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Apr 29, 2019 at 05:07:56PM +0200, Krzysztof Kozlowski wrote:
> On Tue, 23 Apr 2019 at 05:36, Venkata Narendra Kumar Gutta
> <vnkgutta@codeaurora.org> wrote:
> >
> > Platform core is using pdev->name as the platform device name to do
> > the binding of the devices with the drivers. But, when the platform
> > driver overrides the platform device name with dev_set_name(),
> > the pdev->name is pointing to a location which is freed and becomes
> 
> If pdev->name is invalid then it should be removed/fixed. Why leaving
> it pointing to wrong place and changing the users to something else?
> This looks like either duct-tape for real problem.
> 
> > an invalid parameter to do the binding match.
> >
> > use-after-free instance:
> >
> > [   33.325013] BUG: KASAN: use-after-free in strcmp+0x8c/0xb0
> > [   33.330646] Read of size 1 at addr ffffffc10beae600 by task modprobe
> > [   33.339068] CPU: 5 PID: 518 Comm: modprobe Tainted:
> >                         G S      W  O      4.19.30+ #3
> > [   33.346835] Hardware name: MTP (DT)
> > [   33.350419] Call trace:
> > [   33.352941]  dump_backtrace+0x0/0x3b8
> > [   33.356713]  show_stack+0x24/0x30
> > [   33.360119]  dump_stack+0x160/0x1d8
> > [   33.363709]  print_address_description+0x84/0x2e0
> > [   33.368549]  kasan_report+0x26c/0x2d0
> > [   33.372322]  __asan_report_load1_noabort+0x2c/0x38
> > [   33.377248]  strcmp+0x8c/0xb0
> > [   33.380306]  platform_match+0x70/0x1f8
> > [   33.384168]  __driver_attach+0x78/0x3a0
> > [   33.388111]  bus_for_each_dev+0x13c/0x1b8
> > [   33.392237]  driver_attach+0x4c/0x58
> > [   33.395910]  bus_add_driver+0x350/0x560
> > [   33.399854]  driver_register+0x23c/0x328
> > [   33.403886]  __platform_driver_register+0xd0/0xe0
> >
> > So, use dev_name(&pdev->dev), which fetches the platform device name from
> > the kobject(dev->kobj->name) of the device instead of the pdev->name.
> >
> > Signed-off-by: Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
> > ---
> >  drivers/base/platform.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> > index dab0a5a..0e23aa2 100644
> > --- a/drivers/base/platform.c
> > +++ b/drivers/base/platform.c
> > @@ -888,7 +888,7 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *a,
> >         if (len != -ENODEV)
> >                 return len;
> >
> > -       len = snprintf(buf, PAGE_SIZE, "platform:%s\n", pdev->name);
> > +       len = snprintf(buf, PAGE_SIZE, "platform:%s\n", dev_name(&pdev->dev));
> >
> >         return (len >= PAGE_SIZE) ? (PAGE_SIZE - 1) : len;
> >  }
> > @@ -964,7 +964,7 @@ static int platform_uevent(struct device *dev, struct kobj_uevent_env *env)
> >                 return rc;
> >
> >         add_uevent_var(env, "MODALIAS=%s%s", PLATFORM_MODULE_PREFIX,
> > -                       pdev->name);
> > +                       dev_name(&pdev->dev));
> 
> This is wrong fix and it causes ARM Vexpress board fail to boot under
> QEMU (but probably in real world as well). The problem is in not
> mached drivers. For example the pdev->name is "vexpress-syscfg" and
> dev_name(&pdev->dev) is "vexpress-syscfg.6.auto". The effect - none of
> AMBA devices are registered, including missing MMC device (mmci.c,
> arm,pl180).
> 
> One can see the error of missing root device:
> [   13.458982] VFS: Cannot open root device "mmcblk0" or
> unknown-block(0,0): error -6
> 
> ... also before there is a warning like:
> [    0.285029] ------------[ cut here ]------------
> [    0.285507] WARNING: CPU: 0 PID: 1 at
> /home/krzk/dev/yocto-proceq/build/workspace/sources/linux-mainline-next/drivers/bus/vexpress-config.c:183
> vexpress_config_init+0x90/0xe0
> [    0.285936] Modules linked in:
> [    0.286251] CPU: 0 PID: 1 Comm: swapper Tainted: G        W
> 5.1.0-rc6-next-20190429-g0593ae1f5df5 #27
> [    0.286507] Hardware name: ARM-Versatile Express
> [    0.286977] [<8010e05c>] (unwind_backtrace) from [<8010b76c>]
> (show_stack+0x10/0x14)
> [    0.287219] [<8010b76c>] (show_stack) from [<8011ac64>] (__warn+0xf8/0x110)
> [    0.287400] [<8011ac64>] (__warn) from [<8011ad94>]
> (warn_slowpath_null+0x40/0x48)
> [    0.287579] [<8011ad94>] (warn_slowpath_null) from [<809151bc>]
> (vexpress_config_init+0x90/0xe0)
> [    0.287811] [<809151bc>] (vexpress_config_init) from [<80102710>]
> (do_one_initcall+0x54/0x1b4)
> [    0.288014] [<80102710>] (do_one_initcall) from [<80900e84>]
> (kernel_init_freeable+0x12c/0x1c8)
> [    0.288214] [<80900e84>] (kernel_init_freeable) from [<80634048>]
> (kernel_init+0x8/0x110)
> [    0.288388] [<80634048>] (kernel_init) from [<801010e8>]
> (ret_from_fork+0x14/0x2c)
> [    0.288597] Exception stack(0x86835fb0 to 0x86835ff8)
> [    0.288882] 5fa0:                                     00000000
> 00000000 00000000 00000000
> [    0.289193] 5fc0: 00000000 00000000 00000000 00000000 00000000
> 00000000 00000000 00000000
> [    0.289479] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [    0.289776] ---[ end trace 3f0995a2bae83983 ]---

Ick, that's not good, I've now reverted this patch from my tree, thanks
for letting me know.

greg k-h
