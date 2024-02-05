Return-Path: <linux-mmc+bounces-902-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 562B884A3EF
	for <lists+linux-mmc@lfdr.de>; Mon,  5 Feb 2024 20:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E89731F236F2
	for <lists+linux-mmc@lfdr.de>; Mon,  5 Feb 2024 19:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAD6131E51;
	Mon,  5 Feb 2024 19:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BhYStbx0"
X-Original-To: linux-mmc@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFB213175D;
	Mon,  5 Feb 2024 19:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159817; cv=none; b=cgknk8+cQoIbDJ+T1vAJ0hFH4qH5aw6A2wG1wPFyDhT0JwHuFVD94vQsnz1Qv/t/+yHPPMfjgN1IaG2MQHObawZhPTGKjNj5g8jZ/QUlPMyjyubhzhGJ2nmxR8fIzZkiwTvuDGzmIpOif61UONB0SI4cPntJG6fjaXy3hN0plP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159817; c=relaxed/simple;
	bh=Ic8u8OdBrlVsb2wxHY3E0FseBeWYtpT+d7HwrfY/A10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T8uiYUn2yLGrVPd5kHEAWCW4xOIqVbzNZWMbiVeaeZpRSAlP/xleJruD8csxDHs4jKiiLqYUlk1dpuvz1NNsIsavXa3UAYh3qL61ukJW7IUb998hUTQ2WTnP9OFleYahvhpI6rVxK4i9SOaofqlLLF+Rfwxo7kcTtSlXETDQ/zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BhYStbx0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65263C43390;
	Mon,  5 Feb 2024 19:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159816;
	bh=Ic8u8OdBrlVsb2wxHY3E0FseBeWYtpT+d7HwrfY/A10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BhYStbx0yV9w/EWSF3cYdw47hFV+Xiq0rIV/A5Mb/8QwFnZHpMqEtv7Y8W2HzHETE
	 c3OX7GXSuW5dHIMMqAB9hiEKyTH/5nsULyLaFty5LF3tqvo1rDDczDWefNdyQRmcUp
	 QxLM5u2C8odgcbc/gEI6VWNWjgl4mgYGgp3W43ls=
Date: Mon, 5 Feb 2024 04:48:44 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@yahoo.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memstick: core: make memstick_bus_type const
Message-ID: <2024020538-crunchy-jumbo-29cc@gregkh>
References: <20240204-bus_cleanup-memstick-v1-1-14809d4405d8@marliere.net>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-memstick-v1-1-14809d4405d8@marliere.net>

On Sun, Feb 04, 2024 at 05:05:58PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the memstick_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

