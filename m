Return-Path: <linux-mmc+bounces-1185-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A9F860772
	for <lists+linux-mmc@lfdr.de>; Fri, 23 Feb 2024 01:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D48FB224BB
	for <lists+linux-mmc@lfdr.de>; Fri, 23 Feb 2024 00:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCCA372;
	Fri, 23 Feb 2024 00:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FAy7ixHd"
X-Original-To: linux-mmc@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652D77F;
	Fri, 23 Feb 2024 00:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708647144; cv=none; b=jK86iSaueoOVLLjptvmhprgv+9y34m9UPDfwPPnjGYPnTGgJcquWKU6nX95dV/l7hOX8jMmJMaLf6IyFIolJqjxfvm2cBJRkeIMb9YEi67J0KN8JVIPURn5Ivu4tnSoCVqDOP6o8VkJj2MJNNH0DgtpXLcfewLr6wVt9LqGszeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708647144; c=relaxed/simple;
	bh=YRwttCxCPNuyMaZfgHM2hvPQ53QIesQu46wUC6N/G2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCtSmi+ht/HRcW+UCK2N7/RdTnt0M+7ZsK8ZBMm+wwhVAu70/GOaHgY66IjPETq4uMjuOn1U1JYeOflFKSNAGcyvw8HfSDd2ro60Sw+gyGSD6aG27e/5f0BLHRYROHOI3NH2NxTDa0jd6XRWR0FRh5l+TCIboFfIxW9qd/a1Wto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FAy7ixHd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01E03C433F1;
	Fri, 23 Feb 2024 00:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708647143;
	bh=YRwttCxCPNuyMaZfgHM2hvPQ53QIesQu46wUC6N/G2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FAy7ixHdddECoyUfN2VpbbdcDCw0BiohRI+V4sPJ4tPu81UAFTO8u4Xw9aiRybw/y
	 mERvY0NoN0tOnaZLsjZLzkHPgZGIsPP8DK88ZIPtSftTilExNavNQzh8OnMMtqQuPa
	 36lL5KirvSPpRaLsfc43gjVueu8wXBosyb0Ax5VyvGFA5SU4v21g/8fWHJgyDTdMEz
	 cP4FeCfEkJ9qKepTFs5i5m5h3xaUjb69qxnCLJG0/yXtTOQB0sl+rn01enzf6rs14t
	 Pj+Zv/jSyJoyu648mn4qKtTHmvACXXdm55QRaK+vMRt0fuzYoAiVXeawXquG+m0x6i
	 R9Mell2A8+4Fg==
Date: Thu, 22 Feb 2024 17:12:18 -0700
From: Rob Herring <robh@kernel.org>
To: Yang Xiwen <forbidden405@outlook.com>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org,
	David Yang <mmyangfl@gmail.com>,
	Igor Opaniuk <igor.opaniuk@linaro.org>,
	tianshuliang <tianshuliang@hisilicon.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 4/4] dt-bindings: mmc: hisilicon,hi3798cv200-dw-mshc:
 rename to hisilicon,hi3798-dw-mshc
Message-ID: <170864713779.3856761.3190661011256742030.robh@kernel.org>
References: <20240217-b4-mmc-hi3798mv200-v4-0-0fdd9bd48532@outlook.com>
 <20240217-b4-mmc-hi3798mv200-v4-4-0fdd9bd48532@outlook.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240217-b4-mmc-hi3798mv200-v4-4-0fdd9bd48532@outlook.com>


On Sat, 17 Feb 2024 21:00:57 +0800, Yang Xiwen wrote:
> Add binding and an extra property for Hi3798MV200 DWMMC specific extension.
> 
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>  .../bindings/mmc/hisilicon,hi3798cv200-dw-mshc.yaml | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


