Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8B3B5328
	for <lists+linux-mmc@lfdr.de>; Tue, 17 Sep 2019 18:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfIQQgj (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 17 Sep 2019 12:36:39 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40542 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728591AbfIQQgi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Sep 2019 12:36:38 -0400
Received: by mail-pg1-f196.google.com with SMTP id w10so2298988pgj.7
        for <linux-mmc@vger.kernel.org>; Tue, 17 Sep 2019 09:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6oL27CCsiCgWC+s9QdRYX453QCLZxLS2++aHbtnJhwo=;
        b=YA0FtVOqhPZ+x3BfaIoVZIEZexqC9TyNKApW9YBx6UryG5ITeV5G/PcVyovxlcN+mC
         os44E6Ij+VtAx8kdLvm5CDW3dSDIYirj+oo2lcs2vH01UDW4bGLLNb9WTGyjObDvjKoj
         fBuR+TQerwfgIFxcGZl8M9n99ztxdoJWyHTr3aKJskQWgCTjdqc3CzWAMMCPIWWV27uk
         r6QlYUhCtyjRpnvTXR0DG8uzBazHmw40E5sw5yAMAHs41eotxnNZMhM36rvMkaTMxCjz
         4Q5hfisagPglftlQNRwob/iecOFYUAkervhL5SGw2H57K6310ejYzOFpMM61c3xeiltY
         gc0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6oL27CCsiCgWC+s9QdRYX453QCLZxLS2++aHbtnJhwo=;
        b=Vm1RpNfAgpr4Zl9iCwSHfED11V1QwK1SfpPOZvtT0lJfDE/csOcELoWoKUqtCeQdrJ
         ULrPv3f7YWXFbwxbM/HOHuBuUCjFf9GOmoehVGnIRYRpQjHCNxxLnmOtxW/z43U55IDt
         vVaqzc+TTtU5tIj5geLrnyLDzfOwX61PtF5Q+4Y3Vdw3Fk75F5nbHkjKu/HEIvJHgbi1
         GzNmrXzlXPETYlo2KrJbx0dQYegx7KE5cZoH6czRrclposFB2JU0D6T6pmbsRCxe0tzP
         GOcFDeqG4SV1QvgaK25nHsRTHYc9zxtl98Hhz6eY0hYv0shDuAd4lV7SwkKWrA8zPtHT
         v80w==
X-Gm-Message-State: APjAAAVHNZVeFsabsVNSV3hkyH964vGY8KCrI0Ronk2o83EGeGaiyYkU
        1sT29YqI2cJRIKjSU41ulf+3
X-Google-Smtp-Source: APXvYqylABHbwwGnTpG+yB/f0dYMRAjI9T2OAHarx7EJA+9sLbutDPD4P64xC24J0U/cyFBf2nmCMw==
X-Received: by 2002:a17:90a:fa0c:: with SMTP id cm12mr5692720pjb.137.1568738197253;
        Tue, 17 Sep 2019 09:36:37 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:111:7ed:2c13:36f7:e70f:4a47])
        by smtp.gmail.com with ESMTPSA id w6sm8080461pfw.84.2019.09.17.09.36.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Sep 2019 09:36:36 -0700 (PDT)
Date:   Tue, 17 Sep 2019 22:06:28 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     afaerber@suse.de, robh+dt@kernel.org, ulf.hansson@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.liau@actions-semi.com, linux-actions@lists.infradead.org,
        linus.walleij@linaro.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v4 1/7] clk: actions: Fix factor clk struct member access
Message-ID: <20190917163628.GA2615@Mani-XPS-13-9360>
References: <20190916154546.24982-1-manivannan.sadhasivam@linaro.org>
 <20190916154546.24982-2-manivannan.sadhasivam@linaro.org>
 <20190917163419.4C4DD20665@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917163419.4C4DD20665@mail.kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Sep 17, 2019 at 09:34:18AM -0700, Stephen Boyd wrote:
> Quoting Manivannan Sadhasivam (2019-09-16 08:45:40)
> > Since the helper "owl_factor_helper_round_rate" is shared between factor
> > and composite clocks, using the factor clk specific helper function
> > like "hw_to_owl_factor" to access its members will create issues when
> > called from composite clk specific code. Hence, pass the "factor_hw"
> > struct pointer directly instead of fetching it using factor clk specific
> > helpers.
> > 
> > This issue has been observed when a composite clock like "sd0_clk" tried
> > to call "owl_factor_helper_round_rate" resulting in pointer dereferencing
> > error.
> > 
> > While we are at it, let's rename the "clk_val_best" function to
> > "owl_clk_val_best" since this is an owl SoCs specific helper.
> > 
> > Fixes: 4bb78fc9744a ("clk: actions: Add factor clock support")
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> > ---
> 
> I can apply this to clk-next?

Yes, please :-) Rest can go through Ulf's tree.

Thanks,
Mani

> 
