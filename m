Return-Path: <linux-mmc+bounces-85-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D0A7EC775
	for <lists+linux-mmc@lfdr.de>; Wed, 15 Nov 2023 16:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 567EC1F270E3
	for <lists+linux-mmc@lfdr.de>; Wed, 15 Nov 2023 15:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F58439FF4;
	Wed, 15 Nov 2023 15:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2sgtua+"
X-Original-To: linux-mmc@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D0834186;
	Wed, 15 Nov 2023 15:37:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E639AC433C7;
	Wed, 15 Nov 2023 15:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700062661;
	bh=AiZnGVVWhHwGhN3Vdq+4LuWAKRDxyRiM/b2iR4+LgQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q2sgtua+jAxLQDlhigNd9qWhuSQcpDU43jP4CcDB1Xq71GjNQ391gHqlV7j3GScYt
	 dilsn+4LNuLQI9oRCQNTjdELOSVjJEvRuZJ28YjPiYD/4NHQu9W9JOkvGWuiwIrG+a
	 fARoieQBeBRx5/8jaxVNNPrrROlUd3ISEO4fF+zudf14d7n/EhajnTUDZyk+OfUGDH
	 dfAPo+XpSpI77TUtfZRL2KPFQ61w7rI2gBJH0rdGBKuV72qhXkEUDRRG3GlmulR3VV
	 lan9guIC+RXV8vacMWIbidYJUEtOMdiptsr2XYHdJWYvn66/5YG/9OvsdAw619Jwg6
	 9Mbw0XWrJwHcw==
Date: Wed, 15 Nov 2023 23:25:18 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Drew Fustini <dfustini@baylibre.com>
Cc: Conor Dooley <conor@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v6 5/7] riscv: dts: thead: Add TH1520 mmc controllers and
 sdhci clock
Message-ID: <ZVTi3lvSQEXeTbUN@xhacker>
References: <20231114-th1520-mmc-v6-0-3273c661a571@baylibre.com>
 <20231114-th1520-mmc-v6-5-3273c661a571@baylibre.com>
 <20231114-starring-swarm-0e1b641f888c@squawk>
 <ZVP1AoosripWj3gs@x1>
 <ZVTiFVHSsBxk3pLH@xhacker>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZVTiFVHSsBxk3pLH@xhacker>

On Wed, Nov 15, 2023 at 11:22:03PM +0800, Jisheng Zhang wrote:
> On Tue, Nov 14, 2023 at 05:30:26PM -0500, Drew Fustini wrote:
> > On Tue, Nov 14, 2023 at 09:27:44PM +0000, Conor Dooley wrote:
> > > On Tue, Nov 14, 2023 at 04:07:59PM -0500, Drew Fustini wrote:
> > > 
> > > > +	sdhci_clk: sdhci-clock {
> > > > +		compatible = "fixed-clock";
> > > > +		clock-frequency = <198000000>;
> > > > +		clock-output-names = "sdhci_clk";
> > > > +		#clock-cells = <0>;
> > > > +	};
> > > 
> > > If only you had a clock driver to provide these...
> > > 
> > > Is someone working on a resubmission of the clock driver?
> > 
> > Yangtao Li posted an initial revision back [1] in May but I don't think
> > there has been any follow up. It is for sure something we need to have
> > in mainline so I'll take a look at getting that effort going again.
> 
> Hi Drew,
> 
> Based on Yangtao's version, I cooked an updated version in last
> development window but still can't complete it and met some issues
> which need the clk/pll register document.
> IIRC, the document was released a few days ago before soc tree frozen.
> 
> It's nice if you can continue the effort! I'll read the sdhci driver
> soon.

PS: I can send my updated version to you for reference tomorrow.

> 
> Thanks
> > 
> > Drew
> > 
> > [1] https://lore.kernel.org/linux-riscv/20230515054402.27633-1-frank.li@vivo.com/

