Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B3F7E5949
	for <lists+linux-mmc@lfdr.de>; Wed,  8 Nov 2023 15:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbjKHOjQ (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 8 Nov 2023 09:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjKHOjP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Nov 2023 09:39:15 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D001BDA
        for <linux-mmc@vger.kernel.org>; Wed,  8 Nov 2023 06:39:13 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-da30fd994fdso815592276.1
        for <linux-mmc@vger.kernel.org>; Wed, 08 Nov 2023 06:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699454352; x=1700059152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQU3hqMMYcYs/SCmGDlKPzxbDtOph1I+oD4U8+UogTs=;
        b=LKYi4hP1XQiTq/TC86wAlhCVXGr5Y52kOrp56ImzzXJnWRVzean26NU41UfLhWnybF
         DkQcOd+jLLab6r+cFNx+jCBVxv9ShlEmArG6yltanPTT8q+tZHQ5C+WCAZheANuxY7Uo
         FPTmwzaTy5uSMTlC5ZMCy4m/nfm1/8jCEoFhufVIETFyAaSwF2PYlFGRp8JHdxYoc3EG
         2hZfDe8Zwix+UfI2sPWXbIIzxdearItJ6llIF5sge11KiNsifzB0Y8VscYlWKGD4hC3H
         1dp3y2QIz0tq8IMeuqPSDInnqJepoRvMS5LmNwV1LjzEW4+gtdkkCG7lv5hgv3llMFgX
         6+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699454352; x=1700059152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PQU3hqMMYcYs/SCmGDlKPzxbDtOph1I+oD4U8+UogTs=;
        b=dmE1Ixo/fZ4JkxWratWuBr6hdoVo/Ma6VFhMhsdpBIhI6+2P+z0PRSVyjxYSEI/uzP
         TNoHPD1deSLSd+0iVvRTnTtaNLJ70H67uJ+YgkM7qRJMyfb/5AjKELMzcJJE9ke9WG0W
         0+Fitk4e6QXObyc6ue1+ARsmU7skrhPwv8gTe8Lx1HiLzbHZcKVce25U8+7XLsZX1RTj
         SnhkcFgsVHZXmM2hdS1yUFv2xyMzx7mSiPBg1fCOYCj4YKDIKFHi0SfqVZ8jq/oO+sK3
         nAczjL5yhq+8j04xGXbZydTXeQTHyoIZumC2Aq8jzsPerpclJy1caTmPgC2cRITWIKl5
         j/JA==
X-Gm-Message-State: AOJu0Yx4X1oBoqRTMV8Fzwml8uzvI3O+87BAbCKX2FIleTHjy9iZHfpQ
        XZ2orNBNFCi59TamBSne77eNCK19OQAIFNLRCmb3oA==
X-Google-Smtp-Source: AGHT+IFTCIwDBjEMYpwNJ8pCD6O9DyvdbbX4a7hqAkZOe5VRqRtPaWWQozp69ojbFtC4cQ7kVpXUNe0BHNJc/LPtYy4=
X-Received: by 2002:a25:aa73:0:b0:da3:f2c0:dcd4 with SMTP id
 s106-20020a25aa73000000b00da3f2c0dcd4mr1399160ybi.9.1699454352307; Wed, 08
 Nov 2023 06:39:12 -0800 (PST)
MIME-Version: 1.0
References: <20231108141637.119497-1-yann.gautier@foss.st.com>
In-Reply-To: <20231108141637.119497-1-yann.gautier@foss.st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 8 Nov 2023 15:39:00 +0100
Message-ID: <CACRpkda+JjXKO-HS4XHciiTm6GfViCV1vLQ8T1VNtNzK=qe3hA@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: mmci: stm32: add SDIO in-band interrupt mode
To:     Yann Gautier <yann.gautier@foss.st.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-mmc@vger.kernel.org,
        Yang Yingliang <yangyingliang@huawei.com>,
        Ben Wolsieffer <Ben.Wolsieffer@hefring.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Christophe Kerello <christophe.kerello@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Nov 8, 2023 at 3:18=E2=80=AFPM Yann Gautier <yann.gautier@foss.st.c=
om> wrote:

> From: Christophe Kerello <christophe.kerello@foss.st.com>
>
> Add the support of SDIO in-band interrupt mode for STM32 and Ux500
> variants.
> It allows the SD I/O card to interrupt the host on SDMMC_D1 data line.
> It is not enabled by default on Ux500 variant as this is unstable and
> Ux500 users should use out-of-band IRQs.
>
> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>

Still looks good to me!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
