Return-Path: <linux-mmc+bounces-730-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C9983EABA
	for <lists+linux-mmc@lfdr.de>; Sat, 27 Jan 2024 04:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 314681F24CEF
	for <lists+linux-mmc@lfdr.de>; Sat, 27 Jan 2024 03:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6C013ADC;
	Sat, 27 Jan 2024 03:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ki1Xp4SC";
	dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="fjyg3c7k"
X-Original-To: linux-mmc@vger.kernel.org
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428AF134AD;
	Sat, 27 Jan 2024 03:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706327508; cv=none; b=rEJ/jmLmNXXy1qGWCI5X7UA8UiwtaBEAyRzIuuO2y9VBSCKjY6u1q0esuxLD0cUif7aZj8s6epTOpoAPgVTfIxigfpBK1fZKB+vzBKUDS6SyL4d51yRrD7Nzgh0UJ2WHxge0BtIb3o04KG6hAHdk4wX6oUDwusCTtJjpDWi/BJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706327508; c=relaxed/simple;
	bh=ysSO9XRCPehfUIJw/feLeF2vBNwy/Ryu7hrqRS2y+vg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KgDv3xrWlxQLP9pYD8EkOBDRFZC+Vgiu8o9fmJ/HeufpR2ny7pDIo3Fnh/S1/p0p6znVOS2SYHnA9vsYdGTzNuZYNyEygB9kipKCQ179X9mMEtYk+UVze1Agx0GqeV71OUf0aNz/cccJNrRTEWqZzdA1y9Xq273UXRZp59ghtrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ki1Xp4SC; dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=fjyg3c7k; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8D0461CD838;
	Fri, 26 Jan 2024 22:51:44 -0500 (EST)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
	:to:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=sasl; bh=ysSO9XRCPehfUIJw/feLeF2vBNwy/Ryu7hrqRS
	2y+vg=; b=Ki1Xp4SCoVw28DPTb6nSxIu6p1iJM54sMVTV4BIwPPIqGW2tihkOeO
	57fm/CjOL+x3m8b8pLW+HQ4db28QMQu/TArAbvQNcma0OTzuFjM3Lex5ww2OL9xo
	xfLkf6wYLcZVP+4A9sqZ3VirIF/0+Jo/DajESxbWKF24b3eNHpSHE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 836DE1CD837;
	Fri, 26 Jan 2024 22:51:44 -0500 (EST)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=ysSO9XRCPehfUIJw/feLeF2vBNwy/Ryu7hrqRS2y+vg=; b=fjyg3c7kPXv7OMUxssxtQoDSN2KXXxVgR+OZh1QmPbkUshLB0HzksyNvCtjsx/dGkjoFNQbQtpbk65b8HfhXWc6Z/pMIfVgpNhUKODnnM85SpnO+wWI/digIpwmNk+fST9y1GH5N7pOr+B3pewN53A7dsnL5lPdqJvcVDOi1rFI=
Received: from yoda.fluxnic.net (unknown [24.201.101.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 052A01CD835;
	Fri, 26 Jan 2024 22:51:44 -0500 (EST)
	(envelope-from nico@fluxnic.net)
Received: from xanadu (unknown [IPv6:fd17:d3d3:663b:0:9696:df8a:e3:af35])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id DACAAB06A39;
	Fri, 26 Jan 2024 22:51:42 -0500 (EST)
Date: Fri, 26 Jan 2024 22:51:42 -0500 (EST)
From: Nicolas Pitre <nico@fluxnic.net>
To: Linus Walleij <linus.walleij@linaro.org>
cc: linux-mmc@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 5/9] mmc: mvsdio: Use sg_miter for PIO
In-Reply-To: <20240127-mmc-proper-kmap-v2-5-d8e732aa97d1@linaro.org>
Message-ID: <qr2sr893-775p-9770-2441-4o02qqo105or@syhkavp.arg>
References: <20240127-mmc-proper-kmap-v2-0-d8e732aa97d1@linaro.org> <20240127-mmc-proper-kmap-v2-5-d8e732aa97d1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID:
 62FDFBE8-BCC7-11EE-8E23-78DCEB2EC81B-78420484!pb-smtp1.pobox.com

On Sat, 27 Jan 2024, Linus Walleij wrote:

> Use the scatterlist memory iterator instead of just
> dereferencing virtual memory using sg_virt().
> This make highmem references work properly.
> 
> This driver also has a bug in the PIO sglist handling that
> is fixed as part of the patch: it does not travers the
> list of scatterbuffers: it will just process the first
> item in the list. This is fixed by augmenting the logic
> such that we do not process more than one sgitem
> per IRQ instead of counting down potentially the whole
> length of the request.
> 
> We can suspect that the PIO path is quite untested.

It was tested for sure ... at least by myself ... some 17 years ago !

> Suggested-by: Christoph Hellwig <hch@lst.de>
> Link: https://lore.kernel.org/linux-mmc/20240122073423.GA25859@lst.de/
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

[...]

>  		if (!nodma)
> -			dev_dbg(host->dev, "fallback to PIO for data at 0x%p size %d\n",
> -				host->pio_ptr, host->pio_size);
> +			dev_dbg(host->dev, "fallback to PIO for data\n");

Given this message is about telling you why PIO is used despite not 
having asked for it, I think it would be nicer to preserve the 
equivalent info responsible for this infliction i.e. data->sg->offset 
and data->blksz.

The rest looks sane to me ( ... I think).


Nicolas

