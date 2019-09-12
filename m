Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD97B1505
	for <lists+linux-mmc@lfdr.de>; Thu, 12 Sep 2019 22:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfILUEJ (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 12 Sep 2019 16:04:09 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36946 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfILUEJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Sep 2019 16:04:09 -0400
Received: by mail-lj1-f195.google.com with SMTP id y5so14019654lji.4
        for <linux-mmc@vger.kernel.org>; Thu, 12 Sep 2019 13:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=dlSbUffYh87vX8XFargUby+DArN8nxc7+WgEvizRtOk=;
        b=p8eAsF96FBBy97PBGSPmfUR5YfyYqueNYX6lDlnmnhVXKdRnL+kiVCB8ZubK4Hse/i
         VWjcWW0bxVUC9EPK2axFdi9/uq3KoIZSYuTSot0pbcDGJMJD0hVvjIJ7mNPmSX7jN1N3
         5+knXRRonfpK5kT1M8ungO0TnE3NyZws5zBRYWDJbT3P6mO6eFpvKH0uHit0NwcOgc3a
         4y18ZYsfXFgpFHyG11YIfnXJpn7XaBTjjGQwOhT3MfsBSdqlbARd9kW5YRhlZZ6gw4Iu
         Kzk3dxzbhb6ZwWpQXBMl5W7vJlrR4e8iczs+2m8thZwtS3B1hLHzQ8YhwBdsTJW8RsHA
         InRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=dlSbUffYh87vX8XFargUby+DArN8nxc7+WgEvizRtOk=;
        b=EfPhLZWsaxevOmWBjTjYWt46d+DFUmlaq+Xq13IRcmnBXrTVUv8MjualRs4fAoC02J
         7y5fWhJBb0dasTaFZcqVrh0IHEoNOPjrrOa+yfXFxnymiEOwmFLbweYDPmq9jZBfemZj
         EXObENqutZBbM71VzyBgqkE4NC2ci0EE+eywTdyh2xWNvvIcuMqORqq0wLoaYfVJl1NA
         qQAJr0/OQkRz8xXYZYzuL60kfsvMotE8C3Zbh26MVeq2dOCV+kNBFKntQ2xPWgLAR7ql
         x1nmLR++DTzyNyoA8WTVJLkSBVRnRbAavOPgbekraaS/PHn/AY8Wca1fA+/48dtOa4zF
         q8gA==
X-Gm-Message-State: APjAAAUzAUmYNc5pwUGf7TyLr3EMMBX4BDvoV3XDcpNYhdCKs2p7z6mI
        CnNDQNA88BvlsjImNSfSbtupr2WB9EY=
X-Google-Smtp-Source: APXvYqzpWncV0budLVT8z6vDldIgcOp6cLskECQJObHS1uwfTHS2nOIed1YkmEBHUxz3A/2ouMAGCg==
X-Received: by 2002:a05:651c:1021:: with SMTP id w1mr19746096ljm.145.1568318647423;
        Thu, 12 Sep 2019 13:04:07 -0700 (PDT)
Received: from localhost (h-93-159.A463.priv.bahnhof.se. [46.59.93.159])
        by smtp.gmail.com with ESMTPSA id t82sm6590944lff.58.2019.09.12.13.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2019 13:04:06 -0700 (PDT)
Date:   Thu, 12 Sep 2019 22:04:06 +0200
From:   Niklas Soderlund <niklas.soderlund@ragnatech.se>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        Simon Horman <horms+renesas@verge.net.au>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] mmc: tmio: Fixup runtime PM management during probe and
 remove
Message-ID: <20190912200406.GC12549@bigcity.dyn.berto.se>
References: <20190909104649.4960-1-ulf.hansson@linaro.org>
 <CAPDyKFp8ruNvNM-EJxk_eF4YLRzpTU1H4cAyK1jZSk=S+NbmrQ@mail.gmail.com>
 <20190912180547.GD919@kunai>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190912180547.GD919@kunai>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2019-09-12 19:05:47 +0100, Wolfram Sang wrote:
> On Wed, Sep 11, 2019 at 04:16:56PM +0200, Ulf Hansson wrote:
> > On Mon, 9 Sep 2019 at 12:46, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > During probe, tmio variant drivers calls pm_runtime_enable() before they
> > > call tmio_mmc_host_probe(). This doesn't work as expected, because
> > > tmio_mmc_host_probe() calls pm_runtime_set_active(), which fails to set the
> > > status to RPM_ACTIVE for the device, when its been enabled for runtime PM.
> > >
> > > Fix this by calling pm_runtime_enable() from tmio_mmc_host_probe() instead.
> > > To avoid the device from being runtime suspended during the probe phase,
> > > let's also increase the runtime PM usage count in tmio_mmc_host_probe().
> > > Consequentially, each tmio variant driver can decide themselves when to
> > > call pm_runtime_put(), to allow the device to become runtime suspended.
> > >
> > > Additionally, if the tmio variant driver decided to call pm_runtime_put()
> > > during probe, it's is expected that it also calls pm_runtime_get_sync() to
> > > restore the usage count, before it calls tmio_mmc_host_remove().
> > >
> > > Fixes: 7ff213193310 ("mmc: tmio: move runtime PM enablement to the driver implementations")
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > 
> > So I decided to apply this for my fixes branch, as to get it tested
> > for a few days.
> > 
> > If you have any objections, please tell.
> 
> Sadly, I can't test until next week because I am still on the road. Yet,
> I recall Niklas said at LPC that the patch looks good to him, at least.
> 

Yes I think it looks good and was planing to test it. Unfortunately I'm 
also on the road until the end of next week ;-(

-- 
Regards,
Niklas Söderlund
