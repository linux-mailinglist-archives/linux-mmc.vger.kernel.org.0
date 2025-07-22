Return-Path: <linux-mmc+bounces-7554-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14878B0E41C
	for <lists+linux-mmc@lfdr.de>; Tue, 22 Jul 2025 21:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC8471C285C4
	for <lists+linux-mmc@lfdr.de>; Tue, 22 Jul 2025 19:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02DB2853F7;
	Tue, 22 Jul 2025 19:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="geTbU4dT"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7CD2853E5
	for <linux-mmc@vger.kernel.org>; Tue, 22 Jul 2025 19:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753212399; cv=none; b=LCmY9Lym5idGYtDg5iVpoebTZbb+TL/IarO2s9yeXLF1BqN4glLWqDD2FLmmX5WnGn0Q8VqSk8yW3kA2rCpaWYTRj+lYb8JwneiS0O8QUQKLbhZ4RlqsIDVgfMr28jN4g/oXXuUzVkNLemsyRpHP5jsHv1nikiLvY7ljZxBT14A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753212399; c=relaxed/simple;
	bh=mzSoIsEKCwpH21W7Py+zSJvqzc3qFVqilRY8dGbc6Vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EMxFXKBkQloRvg/pTH+gd4sbHPatGSip1OZ5Y2nGTAkfz5IMmeyPruEX1uNhaFhXTrsWgMMrCzYtvQHN8cAwudpjKamH9Ncfh9Rwl28Bu/N6Oi1EmaCeyTci96nheDSoFDS6G2sZ4tQDl/l8QxwA6CAkZcjvnOMs9FIw1plwWFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=geTbU4dT; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=r0se
	VXBzF/UCWTab8iJ+6lvymXg4AvFvgAxbeeeU86g=; b=geTbU4dT4f68eCT1s3Xg
	UAtlpbyUwx5/XC66rzgaunRLiBOuY7IOmhQHpRjuVfC0K6w1y8ONrkHtjhvQDmR6
	n3kzGMXQaQnbL56mZARXvHhAbiv/Ku7ihz81fwkEmEhmedST7stJUO+ntsjdUkCu
	/ARR3xJjSOeN5u7LVi9UnHf4LAGDdNNJOCtJfAiT2VFlHrU11Hb5tSY/7vNgoK7F
	3alohpgR6Nk2qRJgi9Ikn6/rQzfwHcg9clVVIarBj9fqiC/02KW7w3P3rbhTdfdK
	9ohG+Yw9BtXTZg+nW57g8ruXv3Qwo4WTs2rTzsQn2IXPT8ZAuJKNsiMy/oT/SY6H
	nQ==
Received: (qmail 1431530 invoked from network); 22 Jul 2025 21:26:34 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 22 Jul 2025 21:26:34 +0200
X-UD-Smtp-Session: l3s3148p1@lMf5kYk6zM4gAwDPXyBWAATEinPyanBm
Date: Tue, 22 Jul 2025 21:26:34 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: Re: [PATCH RFC/RFT 1/2] mmc: tmio: Add 64-bit read/write support for
 SD_BUF0 in polling mode
Message-ID: <aH_l6rGHPWROE0mG@shikoro>
References: <20250630081315.33288-1-biju.das.jz@bp.renesas.com>
 <20250630081315.33288-2-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630081315.33288-2-biju.das.jz@bp.renesas.com>

On Mon, Jun 30, 2025 at 09:13:10AM +0100, Biju Das wrote:
> As per the RZ/{G2L,G3E} HW manual SD_BUF0 can be accessed by 16/32/64
> bits. Most of the data transfer in SD/SDIO/eMMC mode is more than 8 bytes.
> During testing it is found that, if the DMA buffer is not aligned to 128
> bit it fallback to PIO mode. In such cases, 64-bit access is much more
> efficient than the current 16-bit.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


