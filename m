Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5166AB1863
	for <lists+linux-mmc@lfdr.de>; Fri, 13 Sep 2019 08:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbfIMGh3 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 13 Sep 2019 02:37:29 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36139 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbfIMGh3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Sep 2019 02:37:29 -0400
Received: by mail-ot1-f65.google.com with SMTP id 67so28441229oto.3
        for <linux-mmc@vger.kernel.org>; Thu, 12 Sep 2019 23:37:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bpxBi8gNdgwG0GfZe47AtZZb761TBCv8PwdK6saKpvA=;
        b=fGpTdP60ZmXIcAfD7O9kfC4W6xFlSBwMINa48GEwl6HcQpDvB1zVGb1tAYh4tAFKmO
         obgn+oJ0ACePx4yEwPsuA9e8dh5meqQtBSUr3IUGY0n0lxPmLAve5r4m0Rl+nnqe7vey
         P8IHmHmmzwcg6nedjfctvKZ0tgDZKWO5B1SXaQPoEt9nYlOeyNW8NgdrkTg18TOVYixZ
         z7T+gkPYFIGTLPzG3QidIDvU50cLLKdMxWetiebuGuk0nyCpkHmVUQt0wkgEQ0TfE94N
         C0id9FxQygZrXfnmziDNBbJj1erC91rHP+RKJ5d97tA10jMcnzKAQ0MEIkzFt+2zia+f
         hCbA==
X-Gm-Message-State: APjAAAW7CwPJptrKWJTVhJEDjpWOR7aYM6HFfRqGU4dd6ROfslaBAY/0
        iZAFX1rQz2+ZuzivrhkgpR+CJKZSq1nNJaom1vk=
X-Google-Smtp-Source: APXvYqz+vigRR642Y4x+fKzo6TvznOyXjskn3dDYNSdkJAHKjkhbk0mr6J54xBmOUjPRTXkptZ4agSzJE6qoQihdCLc=
X-Received: by 2002:a05:6830:1196:: with SMTP id u22mr14918450otq.39.1568356648117;
 Thu, 12 Sep 2019 23:37:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190909104649.4960-1-ulf.hansson@linaro.org> <CAPDyKFp8ruNvNM-EJxk_eF4YLRzpTU1H4cAyK1jZSk=S+NbmrQ@mail.gmail.com>
 <20190912180547.GD919@kunai> <20190912200406.GC12549@bigcity.dyn.berto.se>
In-Reply-To: <20190912200406.GC12549@bigcity.dyn.berto.se>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 13 Sep 2019 08:37:16 +0200
Message-ID: <CAMuHMdVpa1F2b=hZGpmUfjmKt=4q=cgjb1vHjx0aAXtLBhF+8A@mail.gmail.com>
Subject: Re: [PATCH] mmc: tmio: Fixup runtime PM management during probe and remove
To:     Niklas Soderlund <niklas.soderlund@ragnatech.se>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        Simon Horman <horms+renesas@verge.net.au>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi all,

On Thu, Sep 12, 2019 at 10:04 PM Niklas Soderlund
<niklas.soderlund@ragnatech.se> wrote:
> On 2019-09-12 19:05:47 +0100, Wolfram Sang wrote:
> > On Wed, Sep 11, 2019 at 04:16:56PM +0200, Ulf Hansson wrote:
> > > On Mon, 9 Sep 2019 at 12:46, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > >
> > > > During probe, tmio variant drivers calls pm_runtime_enable() before they
> > > > call tmio_mmc_host_probe(). This doesn't work as expected, because
> > > > tmio_mmc_host_probe() calls pm_runtime_set_active(), which fails to set the
> > > > status to RPM_ACTIVE for the device, when its been enabled for runtime PM.
> > > >
> > > > Fix this by calling pm_runtime_enable() from tmio_mmc_host_probe() instead.
> > > > To avoid the device from being runtime suspended during the probe phase,
> > > > let's also increase the runtime PM usage count in tmio_mmc_host_probe().
> > > > Consequentially, each tmio variant driver can decide themselves when to
> > > > call pm_runtime_put(), to allow the device to become runtime suspended.
> > > >
> > > > Additionally, if the tmio variant driver decided to call pm_runtime_put()
> > > > during probe, it's is expected that it also calls pm_runtime_get_sync() to
> > > > restore the usage count, before it calls tmio_mmc_host_remove().
> > > >
> > > > Fixes: 7ff213193310 ("mmc: tmio: move runtime PM enablement to the driver implementations")
> > > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > >
> > > So I decided to apply this for my fixes branch, as to get it tested
> > > for a few days.
> > >
> > > If you have any objections, please tell.
> >
> > Sadly, I can't test until next week because I am still on the road. Yet,
> > I recall Niklas said at LPC that the patch looks good to him, at least.
> >
>
> Yes I think it looks good and was planing to test it. Unfortunately I'm
> also on the road until the end of next week ;-(

So I decided to give it a try on my boards.  Note that apart from eMMC,
I do not have any SD cards inserted.

The first thing I noticed, on R-Car Gen2/Gen3:

 sh_mobile_sdhi ee100000.sd: using device tree for GPIO lookup
 of_get_named_gpiod_flags: parsed 'cd-gpios' property of node
'/soc/sd@ee100000[0]' - status (0)
 gpio-812 (cd): gpiod_request: status -16
-PM: ==== always-on/ee100000.sd: start
 gpio_rcar e6055400.gpio: sense irq = 6, type = 3
 sh_mobile_sdhi ee100000.sd: mmc0 base at 0xee100000 max clock rate 195 MHz
 sh_mobile_sdhi ee140000.sd: adding to PM domain always-on
@@ -964,7 +961,6 @@
 sh_mobile_sdhi ee140000.sd: using device tree for GPIO lookup
 of_get_named_gpiod_flags: parsed 'cd-gpios' property of node
'/soc/sd@ee140000[0]' - status (0)
 gpio-820 (cd): gpiod_request: status -16
-PM: ==== always-on/ee140000.sd: start
 gpio_rcar e6055400.gpio: sense irq = 14, type = 3
 sh_mobile_sdhi ee140000.sd: mmc1 base at 0xee140000 max clock rate 97 MHz
 sh_mobile_sdhi ee160000.sd: adding to PM domain always-on
@@ -984,7 +980,6 @@
 sh_mobile_sdhi ee160000.sd: using device tree for GPIO lookup
 of_get_named_gpiod_flags: parsed 'cd-gpios' property of node
'/soc/sd@ee160000[0]' - status (0)
 gpio-828 (cd): gpiod_request: status -16
-PM: ==== always-on/ee160000.sd: start
 gpio_rcar e6055400.gpio: sense irq = 22, type = 3
 sh_mobile_sdhi ee160000.sd: mmc2 base at 0xee160000 max clock rate 97 MHz

The "PM: ==== always-on/ee100000.sd: start" are from debug prints
in genpd_start_dev(). Likewise, I have a similar print in genpd_stop_dev().

So the device is no longer started? Or does it starts in started state?

On SH/R-Mobile, the same happens:

 sh_mobile_sdhi ee100000.sd: adding to PM domain a3sp
 PM: genpd_add_device: Add ee100000.sd to a3sp
-PM: ==== a3sp/ee100000.sd: start
 sh_mobile_sdhi ee100000.sd: mmc0 base at 0xee100000 max clock rate 88 MHz
 sh_mobile_sdhi ee120000.sd: adding to PM domain a3sp
 PM: genpd_add_device: Add ee120000.sd to a3sp
-PM: ==== a3sp/ee120000.sd: start
 sh_mobile_sdhi ee120000.sd: mmc1 base at 0xee120000 max clock rate 12 MHz

But later:

+PM: ==== a3sp/ee120000.sd: stop
 ...
+PM: ==== a3sp/ee120000.sd: start

So it is stopped without being started first, and restarted later.
This fuels the theory that the device starts in started state.
Is that expected?

On R-Car Gen2/Gen3, and some instances on SH/R-Mobile, clk_summary
has changed, compared to before this patch:
-clk_summary:             sdhi0                    3        3        0
   97500000          0     0  50000
+clk_summary:             sdhi0                    1        2        0
   97500000          0     0  50000

On other instances on SH/R-Mobile:
-clk_summary:                sdhi1                 3        3        0
   12500000          0     0  50000
+clk_summary:                sdhi1                 2        2        0
   12500000          0     0  50000

After s2ram, clk_summary has changed, like:

-clk_summary:             sdhi0                    1        2        0
   97500000          0     0  50000
+clk_summary:             sdhi0                    2        2        0
   97500000          0     0  50000

Recently I started tracking regulator_summary changes, too.
S2ram also impacts regulator usecounts, but that may be a pre-existing issue,
as I didn't compare them before:

-regulator_summary: fixed-1.8V                       2    1      0
unknown  1800mV     0mA  1800mV  1800mV
-regulator_summary:    ee140000.sd                   1
                0mA  1800mV  1950mV
-regulator_summary: fixed-3.3V                       2    1      0
unknown  3300mV     0mA  3300mV  3300mV
-regulator_summary:    ee140000.sd                   1
                0mA  3300mV  3400mV
+regulator_summary: fixed-1.8V                       1    1      0
unknown  1800mV     0mA  1800mV  1800mV
+regulator_summary:    ee140000.sd                   0
                0mA  1800mV  1950mV
+regulator_summary: fixed-3.3V                       1    1      0
unknown  3300mV     0mA  3300mV  3300mV
+regulator_summary:    ee140000.sd                   0
                0mA  3300mV  3400mV

Regardless, the eMMC on Salvator-XS is still working.

Does this makes sense?
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
