Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9C6BB4926
	for <lists+linux-mmc@lfdr.de>; Tue, 17 Sep 2019 10:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbfIQITk (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 17 Sep 2019 04:19:40 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:37586 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729126AbfIQITj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Sep 2019 04:19:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2Fth2nxXRWyjF9gPjPNW9zvAWjkUJUEuCZC+A1qY0Vo=; b=YKCdabtXYu1Ki0UHQEzU93mIt
        l6NYw4ccUxF+eDRDs1l1N/RKfSeH7jpYMQhvGz8ycpkbJVWY/BU2DBTV4ryd2gIQmmCko9G87raI3
        Olux7lJqMro1wum3sHCN1xFQNNp4VwwCcPKpLFcy7hrFMXJD2G6D3W4Aw81oegfB8bdUpFFTlNBCx
        zgb2Sl0nd0R33H376zY8yrMrb/SVS5aq4dJFBcFHPIJC+6885fKoY/wBp6HSt4FrvXMZTehHUV8Zl
        Jj1D6/LjUrnBXW8hYjhU1/RaMqLFB8DynPOVEWFWpwTpt8qoKm9GEUj2OKUahq9BZ6f1sU1BJwH7v
        5XQVe4J5A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44678)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iA8hx-0000Mm-Lv; Tue, 17 Sep 2019 09:19:33 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iA8hv-00018B-OD; Tue, 17 Sep 2019 09:19:31 +0100
Date:   Tue, 17 Sep 2019 09:19:31 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [REGRESSION] sdhci no longer detects SD cards on LX2160A
Message-ID: <20190917081931.GI25745@shell.armlinux.org.uk>
References: <20190916171509.GG25745@shell.armlinux.org.uk>
 <b19a0640-5d71-a005-eb0f-c6840f181e5d@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b19a0640-5d71-a005-eb0f-c6840f181e5d@free.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Sep 17, 2019 at 10:06:12AM +0200, Marc Gonzalez wrote:
> On 16/09/2019 19:15, Russell King - ARM Linux admin wrote:
> 
> > The platform has an iommu, which is in pass-through mode, via
> > arm_smmu.disable_bypass=0.
> 
> Could be 954a03be033c7cef80ddc232e7cbdb17df735663
> "iommu/arm-smmu: Break insecure users by disabling bypass by default"
> 
> Although it had already landed in v5.2

It is not - and the two lines that you quoted above are sufficient
to negate that as a cause.  (Please read the help for the option that
the commit referrs to.)

In fact, with bypass disabled, the SoC fails due to other masters.
That's already been discussed privately between myself and Will
Deacon.

arm_smmu.disable_bypass=0 re-enables bypass mode irrespective of
the default setting in the Kconfig.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
