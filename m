Return-Path: <linux-mmc+bounces-205-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 990B07F77C8
	for <lists+linux-mmc@lfdr.de>; Fri, 24 Nov 2023 16:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CACC41C21050
	for <lists+linux-mmc@lfdr.de>; Fri, 24 Nov 2023 15:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAEB2E858;
	Fri, 24 Nov 2023 15:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pm1F5ZgX"
X-Original-To: linux-mmc@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CA62E635;
	Fri, 24 Nov 2023 15:27:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31458C433C7;
	Fri, 24 Nov 2023 15:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700839670;
	bh=3S6A8b26Bij0bNrwt/t+xt24Lf0F8C0vOwZNJyVcNWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pm1F5ZgXuK/SorA+zOMKMQQC8CS03YW6cr2R8Nt24B2t2nTlEQkZAU+W4HJJEAWmA
	 I1lhSuqKqGbN1E7I+fOG54BHhwfOifc7knWoGptLzU5KtVTKvdm7h12SPsPXAnYm9+
	 LM0z2qHnBkOf2DxrOcgZTpZ3VLqT4xnhkoz4Uv+w=
Date: Fri, 24 Nov 2023 15:27:48 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Mark Brown <broonie@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	=?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>
Subject: Re: [PATCH v1 0/3] introduce priority-based shutdown support
Message-ID: <2023112458-stature-commuting-c66f@gregkh>
References: <20231124145338.3112416-1-o.rempel@pengutronix.de>
 <2023112403-laxative-lustiness-6a7f@gregkh>
 <ZWC/hKav0JANhWKM@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWC/hKav0JANhWKM@finisterre.sirena.org.uk>

On Fri, Nov 24, 2023 at 03:21:40PM +0000, Mark Brown wrote:
> On Fri, Nov 24, 2023 at 03:05:47PM +0000, Greg Kroah-Hartman wrote:
> 
> > Anyway, this is ripe for problems and issues in the long-run, what is so
> > special about this hardware that it can not just shutdown in the
> > existing order that it has to be "first" over everyone else?  What
> > exactly does this prevent and what devices are requiring this?
> 
> > And most importantly, what has changed in the past 20+ years to
> > suddenly require this new functionality and how does any other operating
> > system handle it?
> 
> This came out of some discussions about trying to handle emergency power
> failure notifications.

I'm sorry, but I don't know what that means.  Are you saying that the
kernel is now going to try to provide a hard guarantee that some devices
are going to be shut down in X number of seconds when asked?  If so, why
not do this in userspace?

thanks,

greg k-h

