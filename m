Return-Path: <linux-mmc+bounces-1983-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E41008B45AD
	for <lists+linux-mmc@lfdr.de>; Sat, 27 Apr 2024 13:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10A9B1C20F46
	for <lists+linux-mmc@lfdr.de>; Sat, 27 Apr 2024 11:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C63D487A5;
	Sat, 27 Apr 2024 11:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gwnMSzkV"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3E545009
	for <linux-mmc@vger.kernel.org>; Sat, 27 Apr 2024 11:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714215873; cv=none; b=CG4CdFNe4A7p76DmcT5evn5C8K42/NkyTtRoyR4SmMS9y9uzsB2/YXrg0LVqqRHV2AlMzQwbLzt9FEXKvDApb+AwL/Cg/uPvoh6BiA7rM0CPwlTNl4jbO8pU/gUt3rtUdxIEhco1AlzEnWGZj1sVjCTlLvtEiCfeuU2Lp25m31w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714215873; c=relaxed/simple;
	bh=Jgs55Yta8j0IjdvCq9qyuW7D53puLLPSH/O281OOKGc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XdTmaJQuVFkgGompNt1qrt7CvBji+NpoxXOAK2qzXEa8AH8EXsPDIR6WeC12MijzpDelI3SMRZLQC8PPV3BCtJpo9XobY5QXYaG1mkQoKpguCmqteDt8XET+HT83CVkyQnAR0fr9nqyXLCN7pWBC4DoDvWopDVZ4FWu0Kx/5kZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gwnMSzkV; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a556d22fa93so341722866b.3
        for <linux-mmc@vger.kernel.org>; Sat, 27 Apr 2024 04:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1714215868; x=1714820668; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MTsPailerB8pKnIYxWgtzR9tzqjxagTf04yI5tlmVsQ=;
        b=gwnMSzkVc7cZpzaBa0ywKOfp+tfvunxILaR8n6293WaP3f+HHjYBWCksntwA31zkNY
         nOURFF9MM/xbnVPjhKVzsAaSJhNOEiY6bupIq6RkiTuCds+RbpvVnWw5Wf6jp++wfSCO
         Fpddsz+rT7LOwbifB9aFoGei3+1bTe8u3cYpqpqKjvsZCRhKeBs0QYULRNcfcr7o+5Eg
         B7KOCcV/m4/umpcoSN9d5lvj5xHsUx4m8gHOkbNpTQngatMX8EYFFEHdVwITIW1dM2W5
         FqGanSalfzlzRXRff/UyN9qOlO1TxmCGHuJ0JQzPaC90QilImXs95Im2T3REOzk5lv2R
         xivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714215868; x=1714820668;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MTsPailerB8pKnIYxWgtzR9tzqjxagTf04yI5tlmVsQ=;
        b=DuKoIXgR7/5vlKB6r0JwPQPdbG7Zc+n4+8tn+O9VsYpP2zElLqDvXcLxuU/cZCZttg
         /MLy7YK3MudiJQ55M1i1rbE6A6atMrwf7jowgdko2XX1fG2Ac279NFQ9EoOzjE3bNIer
         5j5W/m/8VFJjDK8WTLoiayCoXoHJveHuynxwisKqIs1KiNzolRbIXd5xxO0rNKoWwZRJ
         6K1cxd8xMysQbs7mEbV3AX+9JpOUDLW6LluUX3eJuFi3+e2CAX6ZZcc/i31doZ3IyMph
         47rccJ20ZvKzn3gXOYOM9PDhIJ8uIK1ideIgeueISGvJi332BGZRgtCdFlmCOxtyGdIo
         GA/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXNeUWEKfAtv+1DG5jq3mmycIgLZz8KXJytyPY9JNaFOSZmIForolc+ZjC6wS7GCB0JvelftaocM66ylrJ5B6vIsXASEewwend0
X-Gm-Message-State: AOJu0Yyrl8Mzqxrf+HilLIUE4CNQXujL8AK5INyhVLFh3mjsZoCMj1/t
	odkJ/5UZVOhoVVrwjFZJG6F8yP4F9Q5a1o9keBxh2qCqMLdTmAneAPJyqCSJ3cM=
X-Google-Smtp-Source: AGHT+IFqdQo3aUply0IawVy1XS0TvzAAXhp9V7pYLaZp+QjlIW9AtHR3RC5xslW5BHzpCiw9MRj8TQ==
X-Received: by 2002:a17:906:b80c:b0:a52:3efe:88d3 with SMTP id dv12-20020a170906b80c00b00a523efe88d3mr3206345ejb.67.1714215868564;
        Sat, 27 Apr 2024 04:04:28 -0700 (PDT)
Received: from localhost (host-87-1-234-99.retail.telecomitalia.it. [87.1.234.99])
        by smtp.gmail.com with ESMTPSA id qq22-20020a17090720d600b00a554f6fbb25sm11463605ejb.138.2024.04.27.04.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 04:04:28 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Sat, 27 Apr 2024 13:04:29 +0200
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Phil Elwell <phil@raspberrypi.com>
Subject: Re: [PATCH 4/6] pinctrl: bcm: Add pinconf/pinmux controller driver
 for BCM2712
Message-ID: <ZizbvU8IraOYXUfu@apocalypse>
Mail-Followup-To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Andrea della Porta <andrea.porta@suse.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Phil Elwell <phil@raspberrypi.com>
References: <cover.1713036964.git.andrea.porta@suse.com>
 <8fb5dde9404875777587c867e7bdb4f691ab83f2.1713036964.git.andrea.porta@suse.com>
 <66b11910-c6e2-401c-a293-441f6d85bb90@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <66b11910-c6e2-401c-a293-441f6d85bb90@wanadoo.fr>

On 09:19 Sun 14 Apr     , Christophe JAILLET wrote:
> Le 14/04/2024 � 00:14, Andrea della Porta a �crit�:
> > Add a pincontrol driver for BCM2712. BCM2712 allows muxing GPIOs
> > and setting configuration on pads.
> > 
> > Originally-by: Jonathan Bell <jonathan@raspberrypi.com>
> > Originally-by: Phil Elwell <phil@raspberrypi.com>
> > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> > ---
> >   drivers/pinctrl/bcm/Kconfig           |    9 +
> >   drivers/pinctrl/bcm/Makefile          |    1 +
> >   drivers/pinctrl/bcm/pinctrl-bcm2712.c | 1247 +++++++++++++++++++++++++
> >   3 files changed, 1257 insertions(+)
> >   create mode 100644 drivers/pinctrl/bcm/pinctrl-bcm2712.c
> 
> ...
> 
> > +static int bcm2712_pmx_get_function_groups(struct pinctrl_dev *pctldev,
> > +		unsigned selector,
> > +		const char * const **groups,
> > +		unsigned * const num_groups)
> > +{
> > +	struct bcm2712_pinctrl *pc = pinctrl_dev_get_drvdata(pctldev);
> 
> Missing empty new line.
> 
> > +	/* every pin can do every function */
> > +	*groups = pc->gpio_groups;
> > +	*num_groups = pc->pctl_desc.npins;
> > +
> > +	return 0;
> > +}
> 
> ...
> 
> > +static int bcm2712_pinconf_get(struct pinctrl_dev *pctldev,
> > +			unsigned pin, unsigned long *config)
> > +{
> > +	struct bcm2712_pinctrl *pc = pinctrl_dev_get_drvdata(pctldev);
> > +	enum pin_config_param param = pinconf_to_config_param(*config);
> > +	u32 arg;
> > +
> > +	switch (param) {
> > +	case PIN_CONFIG_BIAS_DISABLE:
> > +		arg = (bcm2712_pull_config_get(pc, pin) == BCM2712_PULL_NONE);
> > +		break;
> > +	case PIN_CONFIG_BIAS_PULL_DOWN:
> > +		arg = (bcm2712_pull_config_get(pc, pin) == BCM2712_PULL_DOWN);
> > +		break;
> > +	case PIN_CONFIG_BIAS_PULL_UP:
> > +		arg = (bcm2712_pull_config_get(pc, pin) == BCM2712_PULL_UP);
> > +		break;
> > +	default:
> > +		return -ENOTSUPP;
> > +	}
> > +
> > +	*config = pinconf_to_config_packed(param, arg);
> > +
> > +	return -ENOTSUPP;
> 
> Strange.
> 
> 	return 0;
> ?
> 
> > +}
> > +
> > +static int bcm2712_pinconf_set(struct pinctrl_dev *pctldev,
> > +			       unsigned int pin, unsigned long *configs,
> > +			       unsigned int num_configs)
> > +{
> > +	struct bcm2712_pinctrl *pc = pinctrl_dev_get_drvdata(pctldev);
> > +	u32 param, arg;
> > +	int i;
> > +
> > +	for (i = 0; i < num_configs; i++) {
> > +		param = pinconf_to_config_param(configs[i]);
> > +		arg = pinconf_to_config_argument(configs[i]);
> > +
> > +		switch (param) {
> > +		case PIN_CONFIG_BIAS_DISABLE:
> > +			bcm2712_pull_config_set(pc, pin, BCM2712_PULL_NONE);
> > +			break;
> > +		case PIN_CONFIG_BIAS_PULL_DOWN:
> > +			bcm2712_pull_config_set(pc, pin, BCM2712_PULL_DOWN);
> > +			break;
> > +		case PIN_CONFIG_BIAS_PULL_UP:
> > +			bcm2712_pull_config_set(pc, pin, BCM2712_PULL_UP);
> > +			break;
> > +		default:
> > +			return -ENOTSUPP;
> > +		}
> > +	} /* for each config */
> 
> This comment is not really usefull, IMHO.

Agreed. Dropped in V2.

> 
> > +
> > +	return 0;
> > +}
> 
> ...
> 
> > +static int bcm2712_pinctrl_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	//struct device_node *np = dev->of_node;
> > +	const struct bcm_plat_data *pdata;
> > +	//const struct of_device_id *match;
> > +	struct bcm2712_pinctrl *pc;
> > +	const char **names;
> > +	int num_pins, i;
> > +
> > +	pdata = device_get_match_data(&pdev->dev);
> > +	if (!pdata)
> > +		return -EINVAL;
> > +
> > +	pc = devm_kzalloc(dev, sizeof(*pc), GFP_KERNEL);
> > +	if (!pc)
> > +		return -ENOMEM;
> > +
> > +	platform_set_drvdata(pdev, pc);
> > +	pc->dev = dev;
> > +	spin_lock_init(&pc->lock);
> > +
> > +	//pc->base = devm_of_iomap(dev, np, 0, NULL);
> 
> Any use for this commented code? (and variable declarations above)

No, I just forgot to drop the comment. Removed in V2.

Many thanks,
Andrea

> 
> CJ
> 
> > +	pc->base = devm_platform_ioremap_resource(pdev, 0);
> > +	if (WARN_ON(IS_ERR(pc->base))) {
> > +		//dev_err(dev, "could not get IO memory\n");
> > +		return PTR_ERR(pc->base);
> > +	}
> > +
> > +	pc->pctl_desc = *pdata->pctl_desc;
> > +	num_pins = pc->pctl_desc.npins;
> > +	names = devm_kmalloc_array(dev, num_pins, sizeof(const char *),
> > +				   GFP_KERNEL);
> > +	if (!names)
> > +		return -ENOMEM;
> > +	for (i = 0; i < num_pins; i++)
> > +		names[i] = pc->pctl_desc.pins[i].name;
> > +	pc->gpio_groups = names;
> > +	pc->pin_regs = pdata->pin_regs;
> > +	pc->pin_funcs = pdata->pin_funcs;
> > +	pc->pctl_dev = devm_pinctrl_register(dev, &pc->pctl_desc, pc);
> > +	if (IS_ERR(pc->pctl_dev))
> > +		return PTR_ERR(pc->pctl_dev);
> > +
> > +	pc->gpio_range = *pdata->gpio_range;
> > +	pinctrl_add_gpio_range(pc->pctl_dev, &pc->gpio_range);
> > +
> > +	return 0;
> > +}
> 
> ...
>
 

