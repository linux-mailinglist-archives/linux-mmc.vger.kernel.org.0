Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9560461E0D
	for <lists+linux-mmc@lfdr.de>; Mon,  8 Jul 2019 13:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730668AbfGHL4g (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 8 Jul 2019 07:56:36 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:46116 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730683AbfGHL4g (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Jul 2019 07:56:36 -0400
Received: by mail-vs1-f65.google.com with SMTP id r3so7997520vsr.13
        for <linux-mmc@vger.kernel.org>; Mon, 08 Jul 2019 04:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IQ8OPkmw07aEeQyb9mErO8HsEQ8fLM7WgoGd9dnI8OQ=;
        b=mfHHkqzVTlPh7DD/CXaqQN1IxI2n1m0H59RqJua4BBVg+5iCaga+ERxDXoHUKbEaQq
         M0oLaH1uL7nA2OJzVPaTjltyNJENi6CoxCBojSt0VeD3ReYSbHjEe3Z0l0FOq9ZGp069
         ZtBpw1G0uP/YQVNLk+KL7lasYV6EMFMTqH6H5F7a1kvNuClhV4RanPtq4aaAYcIXMa6z
         1gNYeK8OICR3H5L+I0eVp371+Mq+pIRd1MENdLApQED1DD+Voi7etHnDPvt6l+/Ugf7z
         KwSFmpdCwN7VOQvTigWk34zWmLIi235TAaKqER4eZH/iR/7JHeXUNOwXS0ImfGkfmlxo
         Jjlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IQ8OPkmw07aEeQyb9mErO8HsEQ8fLM7WgoGd9dnI8OQ=;
        b=DbS8RAPdeGGRaSvy0+F/tsUEiHoE6G0Tu3uY9v/usBHBFTAtamyLSMZkGhcSnzwPVB
         pgozhaKLrXbX3tciP8XGqYbnlEA3bCzHSXNa742r5blcAyKInnm3wQO6umCNFcKCNYsL
         mfCwmRCTax+Q7NUYC2A8qQrmPEYfx8ovlO16M4VhHl8I/aYg1DH/Eqk+9wJcncZX0hNl
         bvX1mT8KJd9dRdo+XJurBOlem6RIds/apGE5HL0MttQyXDUJzAdoY0wzE88w9f850bwp
         +rvCHvQf0jGIISv/VGPck1mieQGM9tSgt8NUGRZJFuYDsHuJ/eH5kAYdt0HM0+rwCnsD
         Av3A==
X-Gm-Message-State: APjAAAXZq19Gh3f+8jqBfltoFjyspT6TA76jSx9iXTOLEuLk1ODDV+/4
        Gg4lSPaF8iBa7XWkYpdK2Kssi5P0l7W1l2wt6t9HYg==
X-Google-Smtp-Source: APXvYqwqtOmX5E+dmwbt6Q18NzrXU5GOE2mxAS6wu10KW6bphP9M7qyNV0agevIeb9KZwCnxq8yI0RElrUtd+y91huQ=
X-Received: by 2002:a67:ee16:: with SMTP id f22mr9850526vsp.191.1562586995022;
 Mon, 08 Jul 2019 04:56:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190701175246.32270-1-colin.king@canonical.com>
In-Reply-To: <20190701175246.32270-1-colin.king@canonical.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 8 Jul 2019 13:55:59 +0200
Message-ID: <CAPDyKFoXEr+DskqQesxJoe+btA3VXzwZKhVZSXLHiw7tiwhX3g@mail.gmail.com>
Subject: Re: [PATCH] mmc: alcor: remove a redundant greater or equal to zero comparison
To:     Colin King <colin.king@canonical.com>
Cc:     Daniel Drake <drake@endlessm.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 1 Jul 2019 at 19:52, Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> A greater or equal comparison on the unsigned int variable tmp_diff
> is always true as unsigned ints are never negative.  Hence the
> comparison is redundant and can be removed.
>
> Addresses-Coverity: ("Unsigned compared against 0")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/alcor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/alcor.c b/drivers/mmc/host/alcor.c
> index e481535cba2b..1aee485d56d4 100644
> --- a/drivers/mmc/host/alcor.c
> +++ b/drivers/mmc/host/alcor.c
> @@ -672,7 +672,7 @@ static void alcor_set_clock(struct alcor_sdmmc_host *host, unsigned int clock)
>                 tmp_clock = DIV_ROUND_UP(cfg->clk_src_freq, tmp_div);
>                 tmp_diff = abs(clock - tmp_clock);
>
> -               if (tmp_diff >= 0 && tmp_diff < diff) {
> +               if (tmp_diff < diff) {
>                         diff = tmp_diff;
>                         clk_src = cfg->clk_src_reg;
>                         clk_div = tmp_div;
> --
> 2.20.1
>
