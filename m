Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75B9A49E14A
	for <lists+linux-mmc@lfdr.de>; Thu, 27 Jan 2022 12:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240577AbiA0LkF (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 27 Jan 2022 06:40:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240535AbiA0LkE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Jan 2022 06:40:04 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D623EC061747
        for <linux-mmc@vger.kernel.org>; Thu, 27 Jan 2022 03:40:03 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id bu18so4768194lfb.5
        for <linux-mmc@vger.kernel.org>; Thu, 27 Jan 2022 03:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XAn7F1Fj4WW9ou4Ks1O1eievoG8rv+B64FUIJS5WS5I=;
        b=xbJwK8QUtP3cFKL/TfgXiBgqq7vvd2bTIygX0QOOqyLDZJeHYh9BHpnGux3lgn1pDe
         ygf4Nm6JS1xfMNgnw4Ju/vbsEGT3dWAMqO80eEcnjLURmd10OV+Op9zWMRNmCiuDUjaO
         P93BhteJLGp6j5hSjnsT8d7IE28UmLxfNblh6i4coQUdWQvhkr/N8xJ25Mayv9cyv6bH
         2h4blnUw6fbqlWKdiWvF7eSqpX6VwQoe8P7/Zrg6lN1s7HoVMDkWJ99Yh8Qgfz/j9PUV
         /rgwslp3fSpDWWo9Ba/LaXiDl7oOXivfF8vc+2YJST/7E379NBY0S9znC9RmA010eihv
         tPXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XAn7F1Fj4WW9ou4Ks1O1eievoG8rv+B64FUIJS5WS5I=;
        b=ZBqRZ+2wcQQo4pPvctz7Ws2LpCtjPFSVpZS4cldB2i6XrM2p7psNYyT1TVGunv1TOV
         M001wHT9ffBHKJh4PsNnFH6d1xj2unUZdx0vP67gEzatZOqBMFog+fzduQmazvIqA9E1
         nG4Ng/QsTE8T0B92QANnJXpXq6CDaBiL/UE/a/mpOAYMn7OCbsJRvO5NpODo/90Yeb3N
         JQctAFPbc1BSSvSdrTjvyhMRL+ZzDd2V1Va8pBtT42gUDyweh2FOwtnwwhYQZYGsoyJG
         F0Et5VC+YSpyxozioweI0gzPQ5XfZMu4/uHBOOnl3PVJbYQQbWGW5hjU5acfJLok7p7Z
         1HKA==
X-Gm-Message-State: AOAM532jw40cSEFNTNkQI0jWPPhcpS6Bn1rMc/TBlFpU7i4gpS/1xUPS
        OBgEttFr/604EzrLxZbs2nkJc9fpmj/WSQ0FGX10pQ==
X-Google-Smtp-Source: ABdhPJwp8sAbw7gkUfgdbqcZH4GVpI/BBc/VRUG5kngzAflTWlKrExOL6Fav6G4XfQIUQgg/og8qSObWAvSAR/cyoHE=
X-Received: by 2002:a05:6512:3d21:: with SMTP id d33mr2549872lfv.373.1643283602134;
 Thu, 27 Jan 2022 03:40:02 -0800 (PST)
MIME-Version: 1.0
References: <20220123175201.34839-1-u.kleine-koenig@pengutronix.de> <20220123175201.34839-6-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20220123175201.34839-6-u.kleine-koenig@pengutronix.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 27 Jan 2022 12:39:22 +0100
Message-ID: <CAPDyKFrZQ0JUjNt_bcxLXVGZ6NtLdUktN7v_4fj--ntoO26TPg@mail.gmail.com>
Subject: Re: [PATCH 5/5] spi: make remove callback a void function
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

- To avoid spamming lists/people, I have dropped most of them from the
to/cc list

On Sun, 23 Jan 2022 at 18:54, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> The value returned by an spi driver's remove function is mostly ignored.
> (Only an error message is printed if the value is non-zero that the
> error is ignored.)
>
> So change the prototype of the remove function to return no value. This
> way driver authors are not tempted to assume that passing an error to
> the upper layer is a good idea. All drivers are adapted accordingly.
> There is no intended change of behaviour, all callbacks were prepared to
> return 0 before.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org> # For MMC

[...]

Kind regards
Uffe
