Return-Path: <linux-mmc+bounces-3854-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D21977821
	for <lists+linux-mmc@lfdr.de>; Fri, 13 Sep 2024 06:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4C4AB24BD7
	for <lists+linux-mmc@lfdr.de>; Fri, 13 Sep 2024 04:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E2D1D47DE;
	Fri, 13 Sep 2024 04:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8wG10cc"
X-Original-To: linux-mmc@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2A413A87C;
	Fri, 13 Sep 2024 04:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726203439; cv=none; b=O6/u734e016lYwFnsB6UkEuhC8Mydl9y9rGAwTThBnKpsn+mpiWLVaXhv54R7gWFkV0pxEl89Lk1vYTISJl9pHu+asYfBoQ+mdofTVdacPK6PzGURJLpS7mmjn4UHzwmHEau3cUl1FTrNtbFeXcdsPL6/GspZDkR1Fr9VN+biyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726203439; c=relaxed/simple;
	bh=um3Mn+EkFIJt96fC+wAnweUqzaADBeYTVtNV6fDcqYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iHydPOJySnvjr1JCoWtuP/MwG+JxiJY/Gsqt5i4NypszPrIM+nAPxYZOMSkWk9R2FH0GvrOT6pUTJp3CxkxaDjvIaBngOZVRPQvc2mYCCfwee5DBJ1pCz1INaxNhtbsfhoTjHUEFJGXgtf/6psSH9rdpqoP4CSXTc3Xt9prla78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8wG10cc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAFDFC4CEC0;
	Fri, 13 Sep 2024 04:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726203438;
	bh=um3Mn+EkFIJt96fC+wAnweUqzaADBeYTVtNV6fDcqYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G8wG10ccIcy28NQh3A63Y8hzlknFxVp2sTHYcviLVe/nQu17xaLGkNMpm2QU2Xlte
	 d71YZ/rlGHofEv3+0v7BGlUa0VQRugG0GnDKksVY689/4cph1bsFZaRHO8Q/cn7c7C
	 BpOrzGfuifqkV45E2Xb2TgTk8/kEPrWxIzp8arOP5bz2FJ/6sCSk2+jNfIPF6JtEC3
	 3Lmlm9OK9GXCxmdEIUx/Q8jAgy82ebTlfQxR68zQefUES2nKEVqNGnODMvBkTZlThK
	 /sAY6qinPLIos4uJJLOQaKE2s4ev0RCqwAlOcE6HiNBL5ZK5fb63FUZFl7zU6pZ/9x
	 xMsJa/UOBlN/g==
Date: Fri, 13 Sep 2024 04:57:16 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: "Gaurav Kashyap (QUIC)" <quic_gaurkash@quicinc.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Asutosh Das <quic_asutoshd@quicinc.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"Theodore Y. Ts'o" <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-fscrypt@vger.kernel.org" <linux-fscrypt@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
	"bartosz.golaszewski" <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v6 09/17] soc: qcom: ice: add HWKM support to the ICE
 driver
Message-ID: <20240913045716.GA2292625@google.com>
References: <20240906-wrapped-keys-v6-0-d59e61bc0cb4@linaro.org>
 <20240906-wrapped-keys-v6-9-d59e61bc0cb4@linaro.org>
 <7uoq72bpiqmo2olwpnudpv3gtcowpnd6jrifff34ubmfpijgc6@k6rmnalu5z4o>
 <66953e65-2468-43b8-9ccf-54671613c4ab@linaro.org>
 <ivibs6qqxhbikaevys3iga7s73xq6dzq3u43gwjri3lozkrblx@jxlmwe5wiq7e>
 <98cc8d71d5d9476297a54774c382030d@quicinc.com>
 <CAA8EJpp_HY+YmMCRwdteeAHnSHtjuHb=nFar60O_PwLwjk0mNA@mail.gmail.com>
 <9bd0c9356e2b471385bcb2780ff2425b@quicinc.com>
 <20240912231735.GA2211970@google.com>
 <CAA8EJpq3sjfB0BsJTs3_r_ZFzhrrpy-A=9Dx9ks2KrDNYCntdg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpq3sjfB0BsJTs3_r_ZFzhrrpy-A=9Dx9ks2KrDNYCntdg@mail.gmail.com>

On Fri, Sep 13, 2024 at 07:28:33AM +0300, Dmitry Baryshkov wrote:
> On Fri, 13 Sept 2024 at 02:17, Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > On Thu, Sep 12, 2024 at 10:17:03PM +0000, Gaurav Kashyap (QUIC) wrote:
> > >
> > > On Monday, September 9, 2024 11:29 PM PDT, Dmitry Baryshkov wrote:
> > > > On Tue, 10 Sept 2024 at 03:51, Gaurav Kashyap (QUIC)
> > > > <quic_gaurkash@quicinc.com> wrote:
> > > > >
> > > > > Hello Dmitry and Neil
> > > > >
> > > > > On Monday, September 9, 2024 2:44 AM PDT, Dmitry Baryshkov wrote:
> > > > > > On Mon, Sep 09, 2024 at 10:58:30AM GMT, Neil Armstrong wrote:
> > > > > > > On 07/09/2024 00:07, Dmitry Baryshkov wrote:
> > > > > > > > On Fri, Sep 06, 2024 at 08:07:12PM GMT, Bartosz Golaszewski wrote:
> > > > > > > > > From: Gaurav Kashyap <quic_gaurkash@quicinc.com>
> > > > > > > > >
> > > > > > > > > Qualcomm's ICE (Inline Crypto Engine) contains a proprietary
> > > > > > > > > key management hardware called Hardware Key Manager (HWKM).
> > > > > > > > > Add
> > > > > > HWKM
> > > > > > > > > support to the ICE driver if it is available on the platform.
> > > > > > > > > HWKM primarily provides hardware wrapped key support where
> > > > the
> > > > > > > > > ICE
> > > > > > > > > (storage) keys are not available in software and instead
> > > > > > > > > protected in
> > > > > > hardware.
> > > > > > > > >
> > > > > > > > > When HWKM software support is not fully available (from
> > > > > > > > > Trustzone), there can be a scenario where the ICE hardware
> > > > > > > > > supports HWKM, but it cannot be used for wrapped keys. In this
> > > > > > > > > case, raw keys have to be used without using the HWKM. We
> > > > > > > > > query the TZ at run-time to find out whether wrapped keys
> > > > > > > > > support is
> > > > > > available.
> > > > > > > > >
> > > > > > > > > Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
> > > > > > > > > Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
> > > > > > > > > Signed-off-by: Bartosz Golaszewski
> > > > > > > > > <bartosz.golaszewski@linaro.org>
> > > > > > > > > ---
> > > > > > > > >   drivers/soc/qcom/ice.c | 152
> > > > > > +++++++++++++++++++++++++++++++++++++++++++++++--
> > > > > > > > >   include/soc/qcom/ice.h |   1 +
> > > > > > > > >   2 files changed, 149 insertions(+), 4 deletions(-)
> > > > > > > > >
> > > > > > > > >   int qcom_ice_enable(struct qcom_ice *ice)
> > > > > > > > >   {
> > > > > > > > > + int err;
> > > > > > > > > +
> > > > > > > > >           qcom_ice_low_power_mode_enable(ice);
> > > > > > > > >           qcom_ice_optimization_enable(ice);
> > > > > > > > > - return qcom_ice_wait_bist_status(ice);
> > > > > > > > > + if (ice->use_hwkm)
> > > > > > > > > +         qcom_ice_enable_standard_mode(ice);
> > > > > > > > > +
> > > > > > > > > + err = qcom_ice_wait_bist_status(ice); if (err)
> > > > > > > > > +         return err;
> > > > > > > > > +
> > > > > > > > > + if (ice->use_hwkm)
> > > > > > > > > +         qcom_ice_hwkm_init(ice);
> > > > > > > > > +
> > > > > > > > > + return err;
> > > > > > > > >   }
> > > > > > > > >   EXPORT_SYMBOL_GPL(qcom_ice_enable);
> > > > > > > > > @@ -150,6 +282,10 @@ int qcom_ice_resume(struct qcom_ice
> > > > *ice)
> > > > > > > > >                   return err;
> > > > > > > > >           }
> > > > > > > > > + if (ice->use_hwkm) {
> > > > > > > > > +         qcom_ice_enable_standard_mode(ice);
> > > > > > > > > +         qcom_ice_hwkm_init(ice); }
> > > > > > > > >           return qcom_ice_wait_bist_status(ice);
> > > > > > > > >   }
> > > > > > > > >   EXPORT_SYMBOL_GPL(qcom_ice_resume);
> > > > > > > > > @@ -157,6 +293,7 @@ EXPORT_SYMBOL_GPL(qcom_ice_resume);
> > > > > > > > >   int qcom_ice_suspend(struct qcom_ice *ice)
> > > > > > > > >   {
> > > > > > > > >           clk_disable_unprepare(ice->core_clk);
> > > > > > > > > + ice->hwkm_init_complete = false;
> > > > > > > > >           return 0;
> > > > > > > > >   }
> > > > > > > > > @@ -206,6 +343,12 @@ int qcom_ice_evict_key(struct qcom_ice
> > > > > > > > > *ice,
> > > > > > int slot)
> > > > > > > > >   }
> > > > > > > > >   EXPORT_SYMBOL_GPL(qcom_ice_evict_key);
> > > > > > > > > +bool qcom_ice_hwkm_supported(struct qcom_ice *ice) {  return
> > > > > > > > > +ice->use_hwkm; }
> > > > > > EXPORT_SYMBOL_GPL(qcom_ice_hwkm_supported);
> > > > > > > > > +
> > > > > > > > >   static struct qcom_ice *qcom_ice_create(struct device *dev,
> > > > > > > > >                                           void __iomem *base)
> > > > > > > > >   {
> > > > > > > > > @@ -240,6 +383,7 @@ static struct qcom_ice
> > > > > > > > > *qcom_ice_create(struct
> > > > > > device *dev,
> > > > > > > > >                   engine->core_clk = devm_clk_get_enabled(dev, NULL);
> > > > > > > > >           if (IS_ERR(engine->core_clk))
> > > > > > > > >                   return ERR_CAST(engine->core_clk);
> > > > > > > > > + engine->use_hwkm = qcom_scm_has_wrapped_key_support();
> > > > > > > >
> > > > > > > > This still makes the decision on whether to use HW-wrapped keys
> > > > > > > > on behalf of a user. I suppose this is incorrect. The user must
> > > > > > > > be able to use raw keys even if HW-wrapped keys are available on
> > > > > > > > the platform. One of the examples for such use-cases is if a
> > > > > > > > user prefers to be able to recover stored information in case of
> > > > > > > > a device failure (such recovery will be impossible if SoC is
> > > > > > > > damaged and HW-
> > > > > > wrapped keys are used).
> > > > > > >
> > > > > > > Isn't that already the case ? the
> > > > BLK_CRYPTO_KEY_TYPE_HW_WRAPPED
> > > > > > size
> > > > > > > is here to select HW-wrapped key, otherwise the ol' raw key is passed.
> > > > > > > Just look the next patch.
> > > > > > >
> > > > > > > Or did I miss something ?
> > > > > >
> > > > > > That's a good question. If use_hwkm is set, ICE gets programmed to
> > > > > > use hwkm (see qcom_ice_hwkm_init() call above). I'm not sure if it
> > > > > > is expected to work properly if after such a call we pass raw key.
> > > > > >
> > > > >
> > > > > Once ICE has moved to a HWKM mode, the firmware key programming
> > > > currently does not support raw keys.
> > > > > This support is being added for the next Qualcomm chipset in Trustzone to
> > > > support both at he same time, but that will take another year or two to hit
> > > > the market.
> > > > > Until that time, due to TZ (firmware) limitations , the driver can only
> > > > support one or the other.
> > > > >
> > > > > We also cannot keep moving ICE modes, due to the HWKM enablement
> > > > being a one-time configurable value at boot.
> > > >
> > > > So the init of HWKM should be delayed until the point where the user tells if
> > > > HWKM or raw keys should be used.
> > >
> > > Ack.
> > > I'll work with Bartosz to look into moving to HWKM mode only during the first key program request
> > >
> >
> > That would mean the driver would have to initially advertise support for both
> > HW-wrapped keys and raw keys, and then it would revoke the support for one of
> > them later (due to the other one being used).  However, runtime revocation of
> > crypto capabilities is not supported by the blk-crypto framework
> > (Documentation/block/inline-encryption.rst), and there is no clear path to
> > adding such support.  Upper layers may have already checked the crypto
> > capabilities and decided to use them.  It's too late to find out that the
> > support was revoked in the middle of an I/O request.  Upper layer code
> > (blk-crypto, fscrypt, etc.) is not prepared for this.  And even if it was, the
> > best it could do is cleanly fail the I/O, which is too late as e.g. it may
> > happen during background writeback and cause user data to be thrown away.
> 
> Can we check crypto capabilities when the user sets the key?

I think you mean when a key is programmed into a keyslot?  That happens during
I/O, which is too late as I've explained above.

> Compare this to the actual HSM used to secure communication or
> storage. It has certain capabilities, which can be enumerated, etc.
> But then at the time the user sets the key it is perfectly normal to
> return an error because HSM is out of resources. It might even have
> spare key slots, but it might be not enough to be able to program the
> required key (as a really crazy example, consider the HSM having at
> this time a single spare DES key slot, while the user wants to program
> 3DES key).

That isn't how the kernel handles inline encryption keyslots.  They are only
programmed as needed for I/O.  If they are all in-use by pending I/O requests,
then the kernel waits for an I/O request to finish and reprograms the keyslot it
was using.  There is never an error reported due to lack of keyslots.

If I/O requests could randomly fail at any time when using inline encryption,
then no one would use inline encryption because it would not be reliable.

> > So, the choice of support for HW-wrapped vs. raw will need to be made ahead of
> > time, rather than being implicitly set by the first use.  That is most easily
> > done using a module parameter like qcom_ice.hw_wrapped_keys=1.  Yes, it's a bit
> > inconvenient, but there's no realistic way around this currently.
> 
> This doesn't work for Android usecase. The user isn't able to setup modparams.

It does work for Android.  The encryption setting that Android uses is
configured in the build of Android for the device (by the OEM, or by whoever
made the build in the case of a custom build).  Refer to
https://source.android.com/docs/security/features/encryption/file-based#enabling-file-based-encryption

Anyone who can change that can also change the kernel command line.

- Eric

