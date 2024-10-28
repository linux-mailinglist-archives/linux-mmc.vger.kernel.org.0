Return-Path: <linux-mmc+bounces-4575-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B9B9B3030
	for <lists+linux-mmc@lfdr.de>; Mon, 28 Oct 2024 13:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 750411F21690
	for <lists+linux-mmc@lfdr.de>; Mon, 28 Oct 2024 12:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5ECD1DC730;
	Mon, 28 Oct 2024 12:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CDPikZJo"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C001DB375
	for <linux-mmc@vger.kernel.org>; Mon, 28 Oct 2024 12:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730118412; cv=none; b=K3k0AOGbbnUL11H3iFeKgR8gTMS98MYoIAmr05eBI87kcscOSh+hYZaQ9y6BHFBhHjhQNCABFvRitRPfVgFUqlFi0Cok+qlnWH8Dyp9JiNMYoqE/wG3vbEsRwDSkWVTPjfGs5aubvU2ngW68Y0Yi2sYA/2disO7ZVX7eS/8qDnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730118412; c=relaxed/simple;
	bh=3PulT3fSYPx07ta8K/JrXit9WxJNJriqpUJ7sJ+UBP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHLa4peeYq3bXlNQkDWE3uHThWYqaQvlx4j8Of//eFYiBZwKSCys+BtZEmbayfTzI5YwuWvilfidXDxoQjJl7pmSjKMilpiGZbFwp+FygnofnXx/VK3CXv1DQ+m9K03NeWjkcPTTRcdhYBtgX6ASDSCpI1dDY16ewf09KEJG04A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CDPikZJo; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539e13375d3so4737246e87.3
        for <linux-mmc@vger.kernel.org>; Mon, 28 Oct 2024 05:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730118407; x=1730723207; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eY9h7I+0Bth8LhQa7GYGkdcbMWz4UGW0FLXHUMtiesc=;
        b=CDPikZJo0Mj3NVB/AQ7HZ7Pj8PcrHx3sxc4McFC+dThWAxTK8oZS+lHXCZBc59WRHh
         +IAFJnnToV7jmb2cKJ+MjcyliUt58TqiaTczbWcpnBCNhP8Fep69xrKytyi7YnJp9BM1
         Uas5y4xvCXDsR4QHJr+eh+P5amgAEmZmJxgEEM2rHKjXFJ3npnEUaZOYqO//C52ij6IS
         BV/TC/j2D4pQq+t5QF3/03EvTKCUAOeko/43zdWMBfKIhmElssSH/4+6YI0TCWSzQq4g
         NNw17IAjtEhhn7sWhBnG3kadIhw8NC846cEvNkLvhuuRSDmruYtba122aBOg8R+WsPXv
         zfIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730118407; x=1730723207;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eY9h7I+0Bth8LhQa7GYGkdcbMWz4UGW0FLXHUMtiesc=;
        b=NLHgGt4ki9jkFb5Miw+ZLfwS8Pf/XVXyp9DwOZ64fDJjEwm/ItqZuyfqUdQkgiwlSl
         7aL8vWzxARVTyCs4q0M4rayfNa0WnRbLLAgrOAYp9QJElwQLa0h0gVqasdK/XGH/9E8S
         6Bb4fr8uj4CSYVphwRLSLOZxm8sEIH4PLs7I89IF01lQIEzcAl0ivuEsqma5B6c/5qqE
         7iavSCnJBi6m3/gSnL0mod9GuAMwf2f19b/nGUdNBNF+E6dyjy19I1OWxuygsLHePUqu
         9jK59EiFdzjIj7Y3vHqVQGaOPOmIhSl6N/eSc8bhnJuy4zfQ8DlZ0PRxy7W+MjsQcvKb
         8WFA==
X-Forwarded-Encrypted: i=1; AJvYcCWV9kffWzqc1/fFaZR7volgQT1xf4cryfaD8JHc+2ev32scNya1IatqHRZ22x8AwuYLRRV67v/nndg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyetdcsnaFA2sxJdJfmDrD4K3T0sYg2NrhFk3pvp2Z+kBRX/bKh
	9yXS4pqWyC+Hn6u3gmh5EiRjDeedKA5TAcvgZV+rnW3cz74vVUezpBDZRS+seoo=
X-Google-Smtp-Source: AGHT+IEZKcB2x5GNVabdEmw8aO9WQ9FCEugl4CW5KcRejhI5DMr6SnMlN5KZjsnO89WQIFFN0/Jrmw==
X-Received: by 2002:a05:6512:acc:b0:530:ae4a:58d0 with SMTP id 2adb3069b0e04-53b348c7067mr2947564e87.8.1730118407183;
        Mon, 28 Oct 2024 05:26:47 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e1f3e21sm1057652e87.288.2024.10.28.05.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 05:26:45 -0700 (PDT)
Date: Mon, 28 Oct 2024 14:26:44 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Sachin Gupta <quic_sachgupt@quicinc.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, quic_cang@quicinc.com, quic_nguyenb@quicinc.com, 
	quic_bhaskarv@quicinc.com, quic_mapa@quicinc.com, quic_narepall@quicinc.com, 
	quic_nitirawa@quicinc.com, quic_rampraka@quicinc.com, quic_sartgarg@quicinc.com
Subject: Re: [PATCH] mmc: sdhci-msm: Slot indexing for distinguishing
 multiple SDCC instances
Message-ID: <2knkpsv3nlbcolosyza3awktztv23kqweow3b3wilbehv2azre@dcldb6a37sbf>
References: <20241022141828.618-1-quic_sachgupt@quicinc.com>
 <3e2f8132-af87-40c0-9c31-c0103078fe39@intel.com>
 <1cb1e8c1-63f4-4752-8358-b5c7078f9c6b@quicinc.com>
 <be483786-d8d2-4d46-9ca2-fbb629ba0674@intel.com>
 <0a0647aa-1fa4-4149-a76d-da7e08034fe4@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0a0647aa-1fa4-4149-a76d-da7e08034fe4@quicinc.com>

On Mon, Oct 28, 2024 at 04:10:37PM +0530, Sachin Gupta wrote:
> 
> 
> On 10/25/2024 6:03 PM, Adrian Hunter wrote:
> > On 25/10/24 13:37, Sachin Gupta wrote:
> > > 
> > > 
> > > On 10/24/2024 4:38 PM, Adrian Hunter wrote:
> > > > On 22/10/24 17:18, Sachin Gupta wrote:
> > > > > This update addresses the requirement for accurate slot indexing
> > > > > in the sdhci-msm driver to differentiate between multiple SDCC
> > > > > (Secure Digital Card Controller) instances, such as eMMC, SD card,
> > > > > and SDIO.
> > > > > 
> > > > > Additionally, it revises the slot indexing logic to comply with
> > > > > the new device tree (DT) specifications.
> > > > 
> > > > This patch seems incomplete because all it does is assign a global
> > > > variable which is never used again.
> > > > 
> > > 
> > > Qualcomm internal debugging tools utilize this global variable to
> > > access and differentiate between all the instance's sdhci_msm_host
> > > data structure (eMMC, SD card, and SDIO).
> > 
> > The kernel does not accept code that does not serve a functional
> > purpose.
> > 
> > You could look at using eBPF or KGDB to get the information,
> > otherwise you might just have to carry that kind of patch in
> > your internal tree.
> > 
> 
> Sorry for misleading sentence, the tool I use is lauterbach Trace32 and when
> using Lauterbach Trace32 tool, having a global variable makes it easier to
> load and inspect dumps. It will be easy to quickly locate and analyze the
> sdhci_msm_host structure, which speeds up the debugging process.

This still isn't a functional purpose. This is a debugging code for a
particular developer debugging SDHCI issues.

> > > > > Signed-off-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
> > > > > Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>
> > > > > Signed-off-by: Maramaina Naresh <quic_mnaresh@quicinc.com>
> > > > > Signed-off-by: Ziqi Chen <quic_ziqichen@quicinc.com>
> > > > > Signed-off-by: Sachin Gupta <quic_sachgupt@quicinc.com>
> > > > > ---
> > > > >  � drivers/mmc/host/sdhci-msm.c | 10 ++++++++++
> > > > >  � 1 file changed, 10 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> > > > > index e113b99a3eab..3cb79117916f 100644
> > > > > --- a/drivers/mmc/host/sdhci-msm.c
> > > > > +++ b/drivers/mmc/host/sdhci-msm.c
> > > > > @@ -292,6 +292,8 @@ struct sdhci_msm_host {
> > > > >  ����� bool vqmmc_enabled;
> > > > >  � };
> > > > >  � +static struct sdhci_msm_host *sdhci_slot[3];
> > > > > +
> > > > >  � static const struct sdhci_msm_offset *sdhci_priv_msm_offset(struct sdhci_host *host)
> > > > >  � {
> > > > >  ����� struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> > > > > @@ -2426,6 +2428,14 @@ static int sdhci_msm_probe(struct platform_device *pdev)
> > > > >  ����� if (ret)
> > > > >  ��������� goto pltfm_free;
> > > > >  � +��� if (node) {
> > > > > +������� ret = of_alias_get_id(pdev->dev.of_node, "mmc");
> > > > > +������� if (ret < 0)
> > > > > +����������� dev_err(&pdev->dev, "get slot index failed %d\n", ret);
> > > > > +������� else
> > > > > +����������� sdhci_slot[ret] = msm_host;
> > > > > +��� }
> > > > > +
> > > > >  ����� /*
> > > > >  ������ * Based on the compatible string, load the required msm host info from
> > > > >  ������ * the data associated with the version info.
> > > > 
> > > 
> > 
> 

-- 
With best wishes
Dmitry

