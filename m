Return-Path: <linux-mmc+bounces-6973-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C47AD3022
	for <lists+linux-mmc@lfdr.de>; Tue, 10 Jun 2025 10:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FA791883C53
	for <lists+linux-mmc@lfdr.de>; Tue, 10 Jun 2025 08:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255B8280A2C;
	Tue, 10 Jun 2025 08:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="TpW+txz1"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482E427FD7E
	for <linux-mmc@vger.kernel.org>; Tue, 10 Jun 2025 08:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749543798; cv=none; b=SkZC4DI2u+Ud3CpwLYcizmKmYN8VkigrtWxQ68qI76pvcVS5yeYqirNqk4mGFBUc3si3zMt0UFjt19IHgxcV+jdj15Y2yBJLJbaCdTGsmtPWscNBcYiY9EU1aXU624D4aR8YY0+jXMdJvIShfFGswZhtWGgL6AqmXHVivz/VAEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749543798; c=relaxed/simple;
	bh=0MgVW9/FtuP76vuXmk+ZR3q4fzt+A4O7VN6kAzR4ExQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lipF0M4DdX0JNfS0D6egGkGsxQRDrJFuvrBCRLhv9BtjOARHdR0m5gEPM9wTBXsk256cWFnwQ0ERhtIpGBeZrarSmRtnRT3AY+L41N/jg1mGDDiNyq9NSN8GxygAhCw3W5VMeVqQn6t7Wx1BxOdlBVVLt553SYB6/WMNVm5H8+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=TpW+txz1; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=0MgV
	W9/FtuP76vuXmk+ZR3q4fzt+A4O7VN6kAzR4ExQ=; b=TpW+txz1qRq7OA61rV6Z
	VGyQ6xfeC1WkkCXmmGMxaHfQepBsDgRw1p7xJjxCmE2FvGD78FlaH/cV8pM/0yHM
	0O9vZ4dzaA2sCYBuW6mLEFCWWW6DCAvukknvUPFQ3z/p+RUy5mVIgvIXvXKRv9YL
	Q4xAwKe/5LwZhf4AiCPgnnlv6VedZcyLX0bdYKOLYiBGct9rgzr8iJSlKkmrnPYZ
	LetZg4k3LgVv8jioIuXWr7q3wAn5wyng3nFZJuYoAeJk7fIIkH02xQwtFtavwfZJ
	xUil1yPcbcC0IcPauI6OktbL7AOB87ntYVjCEf2JalYcx0/VWp0+YGR5pZqOUVh6
	pw==
Received: (qmail 2789934 invoked from network); 10 Jun 2025 10:23:03 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 10 Jun 2025 10:23:03 +0200
X-UD-Smtp-Session: l3s3148p1@5CDAZzM3cMYujnuC
Date: Tue, 10 Jun 2025 10:23:03 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/2] mmc: host: tmio: Add .sdio_irq()
Message-ID: <aEfrZ-MHFmgnBpEE@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
References: <20250610072545.2001435-1-yoshihiro.shimoda.uh@renesas.com>
 <20250610072545.2001435-2-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CUNouKspj6LHLQL7"
Content-Disposition: inline
In-Reply-To: <20250610072545.2001435-2-yoshihiro.shimoda.uh@renesas.com>


--CUNouKspj6LHLQL7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 04:25:44PM +0900, Yoshihiro Shimoda wrote:
> Renesas SDHI controller requires vender specific handling when
> an SDIO irq occurs. So, add .sdio_irq() to the tmio core.
>=20
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--CUNouKspj6LHLQL7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmhH62cACgkQFA3kzBSg
Kba9sBAAobQFJHaXzbB+Q4EfgWceC/+iDOzekDB8rEH7JqE7l0nM3JVw0H81KUJV
kAdj7ILWVfqzbdJYqUWefyyibphIFGmAhEY4gmrn1yK3ZO9bZDHll0XZo4HDHfu7
zJSbweaHpcxQuKg6l/2qC3RvvAxYPTU9WWjoshWitNUrwGDEbH9ivw9ekLMq5wB7
JdoivD8Q9wPUUzYgNR8JGpXzTQnipEYoAAxG0WEzyfYs+Fp/0MUBhJXnHEiprM8D
rBnjINJ1oA7eS4wxq1gy0vvZCs0kkBUhBcO3XHQvaFXUq7LgHr4tHuDB+UCiEYFl
9BeW2etIDlcKXNik/7d9WtQ6/lF11+s+9IuMV3I/NL2RaTUKkAlDTcCvXMfVR3IS
srVkSKeuyNT7Zl/LdF0JGLMq40Ta+0JGoTXJ7kJrMSGElc9dmC894OeEf5RVORs4
9flSWCfF1P4SH4ilYiFoRz9oWfp/QsT+vOzLX9RvLuOUb7cjI/7mAKl1KaOhsTyR
uoiA/bFcSCAyxIFoZPtpzVRWWwsxXdD/UgE3sqjjfk/ARW+3v1oaMyh5P6WbHvry
1hSZi26Ac4gjcZnzAk5Lufq45t8H7FdOV6NjuPSedEKMz18fjoPSOhH0hMVs0IAx
yusLMRn7s5YZmW7iS2ZcscvIJCnVr356mlsE3AqewFBKK8GpZz0=
=AxQK
-----END PGP SIGNATURE-----

--CUNouKspj6LHLQL7--

