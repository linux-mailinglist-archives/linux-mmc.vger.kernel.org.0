Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215374BA3CA
	for <lists+linux-mmc@lfdr.de>; Thu, 17 Feb 2022 15:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242221AbiBQOzD (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 17 Feb 2022 09:55:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242224AbiBQOzC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Feb 2022 09:55:02 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D67296909
        for <linux-mmc@vger.kernel.org>; Thu, 17 Feb 2022 06:54:45 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id d23so10424515lfv.13
        for <linux-mmc@vger.kernel.org>; Thu, 17 Feb 2022 06:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=11Msxpj6saXhCjkH+nNzBnzST2VwOlijviYdJ5EL8xY=;
        b=h5HMBr2qhvXOVt5Rfn/vHXtiCQDuOpsxkvtFXY0SaiScqWYvwpMJt7Ts5GoC0oM9lu
         oZj3IfLiiIcHvrxc3JwV25jjQsMvXlueV81dkAF15o0UJ2Wc1KHJgUiBV6+YYsPTH98G
         8nWuYP3W8FBS6N4SeEuBzBAYUDcjwdH/gP8aX0MTiZXvEu4z93liPMgb34C5FYDQctPi
         G5G0CrnohL2XTBUHXFu9UhV0YmK4fiIERHclNELjygJMVr+BGfUBjhvEtptQCK+yxtkm
         aeY1WFNrw8P8mIxnuUxVsLdP4wnwmi1KwCEPf/m/0deGHDK0O/gNRAMxVaGIpLfuPW6C
         jOmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=11Msxpj6saXhCjkH+nNzBnzST2VwOlijviYdJ5EL8xY=;
        b=5cIWyUdv6oLrnGciOIQflXdT0rWLA9QB7lsd6NpRDLc6Pwd5vugzmQjKF1wAX9XFIy
         FOfJJM6CuJJAKFNgj6En00881jgtTASCwcHx4AQtPMzlFPrCnKIEFQmxCzHX5ZO3j8jJ
         nDLZQOSLDHw3fNnw6Kzh1AgTvoyWEBa+E5Zu4M4Z04Ok08yCv0jvjJvIKE+tXOY5o7nG
         FnC+0eqXYdvD74Pvq+Sj91NT8UeBPRdYMNmj9OuGJ67of2lnwGoNGd6nfy0Jw2rFcaAe
         0ZJkclhAYgJGNmKGmlkp86SPc7N/TTvUlYqixCqKiZdIbcxuDg6CbcFMpke0Hbt7SVeE
         K+Pw==
X-Gm-Message-State: AOAM530fSaHycMy1AZ6m+XWI8mWo86KcOLbrmEuLaPxAoUStW3jO71e2
        9Jd58SIO+EDdEyPtJoP0WqeUBry7F9YiV4cuPatveA==
X-Google-Smtp-Source: ABdhPJxr6FXLaH1va6dG7alhD1yu9EwTbfNIoN/IWCmHeyc0IwCpkdkpbk1bdcrCPBR912vFQwi6slrPY3X5Othxofw=
X-Received: by 2002:a19:9144:0:b0:43b:86a4:1497 with SMTP id
 y4-20020a199144000000b0043b86a41497mr2301608lfj.254.1645109683832; Thu, 17
 Feb 2022 06:54:43 -0800 (PST)
MIME-Version: 1.0
References: <20220216093112.92469-1-Jerome.Pouiller@silabs.com>
 <20220216093112.92469-3-Jerome.Pouiller@silabs.com> <878ru924qr.fsf@kernel.org>
In-Reply-To: <878ru924qr.fsf@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 17 Feb 2022 15:54:05 +0100
Message-ID: <CAPDyKFqm3tGa+dtAGPn803rLnfY=tdcoX5DySnG-spFFqM=CrA@mail.gmail.com>
Subject: Re: [PATCH 2/2] staging: wfx: apply the necessary SDIO quirks for the
 Silabs WF200
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Jerome Pouiller <Jerome.Pouiller@silabs.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        linux-mmc@vger.kernel.org,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 17 Feb 2022 at 10:59, Kalle Valo <kvalo@kernel.org> wrote:
>
> Jerome Pouiller <Jerome.Pouiller@silabs.com> writes:
>
> > From: J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com>
> >
> > Until now, the SDIO quirks are applied directly from the driver.
> > However, it is better to apply the quirks before driver probing. So,
> > this patch relocate the quirks in the MMC framework.
>
> It would be good to know how this is better, what's the concrete
> advantage?

The mmc core has a quirk interface for all types of cards
(eMMC/SD/SDIO), which thus keeps these things from sprinkling to
drivers. In some cases, the quirk needs to be applied already during
card initialization, which is earlier than when probing an SDIO func
driver or the MMC block device driver.

Perhaps it's a good idea to explain a bit about this in the commit message.

Kind regards
Uffe
